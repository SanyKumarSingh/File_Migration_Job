#!/bin/bash
#********************* 
# Shell Script to migrate the files from Parser NFS Processed directory .snapshot to the OCI Object Storage.
#
# Copy the File from Local to UnixBox
# scp C:\Users\a5143522\CodeBase\PythonJobs\copy_gz_job.sh ocradmin@oeforapars001d.adwin.renesas.com:/localdisk/ocradmin/bin
# scp /localdisk/ocradmin/bin/copy_gz_job.sh ocradmin@oeforapars003p.adwin.renesas.com:/localdisk/ocradmin/bin
# 
# Convert the file from Windows to Unix Format
# [ocradmin@oeforapars001d bin]$ dos2unix /localdisk/ocradmin/bin/copy_gz_job.sh
# dos2unix: converting file /localdisk/ocradmin/bin/copy_gz_job.sh to Unix format...
# 
# Execution/Run Shell Script command  - [ocradmin@oeforapars001d bin]$ sh /localdisk/ocradmin/bin/copy_gz_job.sh
#
# Execution Shell via nohup to open a new session to run in the background
# [ocradmin@oeforapars001d bin]$ nohup /localdisk/ocradmin/bin/copy_gz_job.sh  > outpufile_copy_job 2>&1 &
# [1] 1997781
# -rw-r--r--.  1 ocradmin dlgusers   22 Apr 12 14:34 outpufile_copy_job
# [1]+  Done                    nohup /localdisk/ocradmin/bin/copy_gz_job.sh > outpufile_copy_job 2>&1
# [ocradmin@oeforapars001d bin]$ tail -1000 outpufile_copy_job
# nohup: ignoring input
#
#**********************

# Source directory
src_dir="/localdisk/ocradmin/bin/test"

# Destination directory
dest_dir="/localdisk/ocradmin/log/test"

echo "#### Started Processing $(date)"  >> /localdisk/ocradmin/log/copy_job.log 2>&1

# Count total number of files in source directory
total_files=$(find "$src_dir" -type f | wc -l)
echo "Total number of files in $src_dir: $total_files"  >> /localdisk/ocradmin/log/copy_job.log 2>&1

# Iterate through files in source directory
for file in "$src_dir"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "----------- STARTING WORKING WITH $filename --------------" >> /localdisk/ocradmin/log/copy_job.log 2>&1
        # Check if file is .zip|.gz
        case "$filename" in
            *.zip|*.gz)
                echo "$(date): Copying $filename to $dest_dir" >> /localdisk/ocradmin/log/copy_job.log 2>&1
                cp "$file" "$dest_dir"
                if [ $? -eq 0 ]; then
                    echo "$(date): Copied $filename to $dest_dir" >> /localdisk/ocradmin/log/copy_job.log 2>&1
                else
                    echo "$(date): Failed to copy $filename to $dest_dir" >> /localdisk/ocradmin/log/copy_job.log 2>&1
                fi
                ;;
            *)
                echo "$(date): Copying $filename to $dest_dir" >> /localdisk/ocradmin/log/copy_job.log 2>&1
                cp "$file" "$dest_dir"
                if [ $? -eq 0 ]; then
                    echo "$(date): Copied $filename to $dest_dir" >> /localdisk/ocradmin/log/copy_job.log 2>&1
                    gzip -f "$dest_dir/$filename"
                    if [ $? -eq 0 ]; then
                        echo "$(date): Compressed $filename into $filename.gz" >> /localdisk/ocradmin/log/copy_job.log 2>&1
                    else
                        echo "$(date): Failed to compress $filename" >> /localdisk/ocradmin/log/copy_job.log 2>&1
                    fi
                else
                    echo "$(date): Failed to copy $filename to $dest_dir" >> /localdisk/ocradmin/log/copy_job.log 2>&1
                fi
                ;;
        esac
        echo "----------- FINISH WORKING WITH $filename --------------" >> /localdisk/ocradmin/log/copy_job.log 2>&1
    fi
done

# Count total number of files in destination directory
total_files=$(find "$dest_dir" -type f | wc -l)
echo "Total number of files in $dest_dir: $total_files"  >> /localdisk/ocradmin/log/copy_job.log 2>&1

echo "#### Completed Processing $(date)"  >> /localdisk/ocradmin/log/copy_job.log 2>&1

