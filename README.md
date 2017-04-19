# mesos_script
This is a repository to mesos

Limpiar los registros que se tenian del slave

```sudo rm -f /var/lib/mesos/meta/slaves/latest```

Se necesito de estos comando para poder levantar de manera activa a los slaves

```/usr/sbin/mesos-slave --master=zk://10.110.70.47:2181/mesos --log_dir=/var/log/mesos --hostname=10.110.70.167 --ip=10.110.70.167 --work_dir=/var/lib/mesos ```

Comando utilizado para levantar el job en mesos
``` curl -X POST http://10.110.70.45:8080/v2/apps -d @app.json -H "Content-type: application/json"  ```
