# code to split a json file into a certain number of smaller files

import json

input_file = "data/yelp_academic_dataset_review.json" # file to split
output_prefix = "data/split_file_" # prefix for output
num_files = 25 # split into 5 files

with open(input_file, "r", encoding = "utf8") as file:
    total_lines = sum(1 for _ in file) # count of all objects

lines_in_file = total_lines // num_files # floor division to get the num of lines in each split
print(f"Total lines: {total_lines}, Lines in each file: {lines_in_file}")

# Split data into smaller files
with open(input_file, "r", encoding="utf8") as file:
    for i in range(num_files):
        output_filename = f"{output_prefix}{i+1}.json" # name of each output file

        with open(output_filename, "w", encoding="utf8") as out_file:
            for j in range(lines_in_file):
                line = file.readline()
                if not line:
                    break # if at end of file (no lines left), break out of loop
                out_file.write(line)

print("Files split successfully")