# mesos_script

## Instalación de mesos.

Se realizará la instalación de mesos y   marathon.

```sudo yum -y install mesos marathon ```

Installar zookeeper

``` sudo yum -y install mesosphere-zookeeper```


## Configuración


Limpiar los registros que se tenian del slave con el siguiente comando:

```sudo rm -f /var/lib/mesos/meta/slaves/latest```

Se necesito de estos comando para levantar el slave con el master. 

```/usr/sbin/mesos-slave --master=zk://10.110.70.45:2181/mesos --log_dir=/var/log/mesos --hostname=10.110.70.170 --ip=10.110.70.170 --work_dir=/var/lib/mesos ```

Se creo un arvchi

Comando utilizado para levantar el job en mesos

``` curl -X POST http://10.110.70.45:8080/v2/apps -d @app.json -H "Content-type: application/json"  ```
