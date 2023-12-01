import subprocess
import yaml
import sys
import os

installer_location = "/home/joris/dotfiles"
installer_config = installer_location+ "/" + "install.conf.yaml"
installer_scripts_location = installer_location + "/installer/scripts"
dotfiles_location = installer_location + "/" + "config/"
install_destination = installer_location + '/' + "target"
config = yaml.load(open(installer_config, "r"), Loader=yaml.FullLoader)
dotfiles = os.listdir(dotfiles_location)
args = sys.argv
arg_amount = len(args) - 1

def cmd(stdin):
    return subprocess.call(stdin.split(' '))

def pwd():
    return cmd("pwd")[1]


def symlink(source, destination):
    return cmd("ln -s {} {}".format(source, destination))

def clean_dotfiles():
    for item in dotfiles:
        fullpath = os.path.join(dotfiles_location, item)
        target_path = os.path.join(install_destination, item)

        if os.path.islink(target_path):
            os.unlink(target_path)

def symlink_dotfiles():
    # If the links aren't removed first there will be a link to 
    # itself in the target AND source folder.
    clean_dotfiles()

    for item in dotfiles:
        is_custom_link = False
        try:
            if any(item in s for s in config["links"]):
                is_custom_link = True
                continue
        except:
            pass

        fullpath = os.path.join(dotfiles_location, item)
        target_path = os.path.join(install_destination, item)
        if not is_custom_link:
            symlink(fullpath, target_path)

def adapter_pacman():
    return "sudo pacman -Fy --noconfirm; sudo pacman -Syu {} --noconfirm".format(" ".join(config["packages"]["pacman"]))

def adapter_yay():
    is_installed = cmd("which yay")
    if is_installed != 0:
        print("yay not installed, installing yay")
        cmd("git clone https://aur.archlinux.org/yay.git")
        cmd("cd yay && makepkg -si --noconfirm; cd ..; rm -rf yay")
    
    return "yay -S {} --noconfirm".format(" ".join(config["packages"]["yay"]))

available_adapters = {
    "pacman": adapter_pacman,
    "yay": adapter_yay
}

def install_packages():
    for adapter in config["packages"]:
        if adapter in available_adapters:
            print("Installing packages for {}".format(adapter))
            cmd(available_adapters[adapter]())

def run_install_scripts():
    entries = os.listdir(installer_scripts_location)
    for entry in entries:
        fullpath = os.path.join(installer_scripts_location, entry)
        cmd(fullpath)

if arg_amount == 0:
    print("Bootstrapping machine")
    symlink_dotfiles()
    install_packages()
    run_install_scripts()
elif arg_amount == 1:
    if args[1] == "clean":
        clean_dotfiles()
    elif args[1] == "link":
        symlink_dotfiles()
    elif args[1] == "packages":
        install_packages()
    elif args[1] == "scripts":
        run_install_scripts()
elif arg_amount == 2:
    if args[1] == "clean" and args[2] == "dotfiles":
        clean_dotfiles()
    elif args[1] == "link" and args[2] == "dotfiles":
        clean_dotfiles()
        symlink_dotfiles()
    if args[1] == "packages" and args[2] == "pacman":
        install_packages()
    elif args[1] == "scripts":
        run_install_scripts()