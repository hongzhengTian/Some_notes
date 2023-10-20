# Some helpful command in Linux usage

## To move the files, run

```sh
mv /home/<your-name>/<your-file-path>/ /home/data/<your-name>/<your-file-path>/
```

## To create a link run

```sh
ln -s /home/<your-name>/<your-file-path>/ /home/data/<your-name>/<your-file-path>/
```

## To check the size of folders in the current path, run

```sh
du -h --max-depth=1 . | sort -h 
```
