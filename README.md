# Linux Stress Test
This script is for creating dummy load on the Linux server.
## Description
1. Below is the 'stress' command to load cpu, memory and i/o. A load average of four is imposed on the system by specifying 2 CPU core, 1 I/O process and 1 Memory process as follows:
```bash
$ stress --cpu 2 --io 1 --vm 1 --vm-bytes 128M --timeout 10
```
   --cpu (-c) 2 : Spawn two workers spinning on sqrt()
   --io (-i) 1 : Spawn one worker spinning on sync()
   --vm(-m) 1 : Spawn one worker spinning on malloc()/free()
   --vm-bytes 128M : Malloc 128MB per vm worker (default is 256MB)
   --timeout (-t) 10 : Timeout after 10 seconds

2. Below dd command is used to create a file of 1MB (count*bs bytes) on the test server.
  - First make sure you’ve sufficient disk space to create file:
```bash
$ df -H
```

- If you just want to create a file of a any particular size and least bothered about the file content, use if=/dev/zero. This option provides a null character every time you try to read from it. The disadvantage of this option is the fact that the file will only contain null characters and as a result will not seem to contain any lines.
Sample Output:
```bash
$ dd if=/dev/zero of=zero1m bs=1048576 count=1
1+0 records in
1+0 records out
1048576 bytes transferred in 0.000624 secs (1680568021 bytes/sec)
```

- If you just want to create a file of a any particular size without null characters but don’t really matter on the file content, use if=/dev/urandom. The disadvantages go this option is the file does not contain anything readable and the fact that it is quite a bit slower than the if=/dev/zero method. The advantage is the file will contain some lines.
Sample Output:
```bash
$ dd if=/dev/urandom of=urandom1m bs=1048576 count=1
1+0 records in
1+0 records out
1048576 bytes transferred in 0.088734 secs (11817051 bytes/sec)
```

Note: The time taken by both the methods for same 1MB file size.

3. Below scp command is used to file transfer to and from the test server supplying your password when prompted
```bash
scp -q <filename> <username>@remoteserverIP:~/<path>
```

The password-less operation can be achieved by copying the .pub file as authorized_keys from your local machine to remote machine under .ssh directory under user home. Now, try to ssh the remote server which will connect without password.
Use the below command from your local terminal to copy your public key to the remote server. You will be asked for password to copy the .pub file. This is a one time activity.

```bash
$ cat .ssh/id_rsa.pub | ssh <remoteusername>@<remoteserverIP> 'cat >> .ssh/authorized_keys'
```