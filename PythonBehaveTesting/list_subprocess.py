import subprocess

# list_files = subprocess.run(["ls", "-l"])
list_files = subprocess.run(["ls", "-l"], stdout=subprocess.DEVNULL)
print("The exit code was: %d" % list_files.returncode)
# https://stackabuse.com/executing-shell-commands-with-python/