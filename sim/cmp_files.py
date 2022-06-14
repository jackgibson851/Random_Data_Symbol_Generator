import filecmp
from pathlib import Path

if __name__ == "__main__":
    matlab_file = "log/datagen_result_ref.dat"
    vhdl_file = "log/datagen_result.dat"
    with open(vhdl_file, "rt") as f:
        content = f.readlines()
     
    new_content = list()
    for line in content:
        if '127' in line:
            line = line.replace('127', '1')
        elif '128' in line:
            line = line.replace('-128', '-1')
        new_content.append(line)
    with open(vhdl_file, "w") as f:
        for line in new_content:
            f.write(line)
    if Path(matlab_file).stat().st_size == Path(vhdl_file).stat().st_size:
        if filecmp.cmp(matlab_file, vhdl_file) is True:
            print("The files are the same")
        else:
            print("The files are not the same")
    else:
        print("The files do not have the same byte size, so they cannot be the same")
