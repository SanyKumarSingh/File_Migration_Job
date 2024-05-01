#Automation Jobs Scripts

# copy_gz_job.sh
Shell Script to migrate the files from Parser NFS Processed directory .snapshot to the OCI Object Storage.

Copy the File from Local to UnixBox
scp C:\Users\a5143522\CodeBase\PythonJobs\copy_gz_job.sh ocradmin@oeforapars001d.adwin.renesas.com:/localdisk/ocradmin/bin
scp /localdisk/ocradmin/bin/copy_gz_job.sh ocradmin@oeforapars003p.adwin.renesas.com:/localdisk/ocradmin/bin

Convert the file from Windows to Unix Format
[ocradmin@oeforapars001d bin]$ dos2unix /localdisk/ocradmin/bin/copy_gz_job.sh
dos2unix: converting file /localdisk/ocradmin/bin/copy_gz_job.sh to Unix format...

Execution/Run Shell Script command  - [ocradmin@oeforapars001d bin]$ sh /localdisk/ocradmin/bin/copy_gz_job.sh

Execution Shell via nohup to open a new session to run in the background
[ocradmin@oeforapars001d bin]$ nohup /localdisk/ocradmin/bin/copy_gz_job.sh  > outpufile_copy_job 2>&1 &
[1] 1997781
-rw-r--r--.  1 ocradmin dlgusers   22 Apr 12 14:34 outpufile_copy_job
[1]+  Done                    nohup /localdisk/ocradmin/bin/copy_gz_job.sh > outpufile_copy_job 2>&1
[ocradmin@oeforapars001d bin]$ tail -1000 outpufile_copy_job
nohup: ignoring input
