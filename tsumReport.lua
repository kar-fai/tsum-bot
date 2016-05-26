command = string.format([[
cd %s;
bash init.sh;
]], rootDir().."www")

os.execute(command)