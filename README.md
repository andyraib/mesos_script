# mesos_script

## Instalación de mesos.

Se realizará la instalación de mesos y   marathon.

```sudo yum -y install mesos marathon ```

Installar zookeeper

``` sudo yum -y install mesosphere-zookeeper```


## Configuración MASTER

Para realizar la configuración del master fue necesario configurar en cada nodo (tanto master y slaves) la dirección IP en el archivo ZK de mesos , en este caso, con la dirección IP 10.110.70.45

`sudo vim  /etc/mesos/zk`

`zk://10.110.70.45:2181/mesos `

Se modificaŕa el archivo  QUORUM, con un valor de 1

`sudo nano /etc/mesos-master/quorum `

`1`

Se especifica el hostname y la IP en el mesos-master

`echo 10.110.70.45 | sudo tee /etc/mesos-master/ip`

`sudo cp /etc/mesos-master/ip /etc/mesos-master/hostname`


## Configuración marathon 

Si no se tiene el directorio `marathon`, se creará el 	directorio

`sudo mkdir -p /etc/marathon/conf`

Se necesita definir la lista de los master que usara el Marathon, se copiarán el archivo zk de mesos en el directorio creado anteriormente, lo que nos permitirá conectar el marathon con nuestro cluster de mesos

`sudo cp /etc/mesos/zk /etc/marathon/conf/master`

Se necesita almacenar el estado de marathon en nuestro zookeeper, por lo que es necesario conectar nuestro zookeeper con marathon con el siguiente comando y modificando el `mesos` por `marathon`


` sudo cp /etc/marathon/conf/master /etc/marathon/conf/zk `
Antes 

`zk://192.0.2.1:2181,192.0.2.2:2181,192.0.2.3:2181/mesos`

Después
` zk://192.0.2.1:2181,192.0.2.2:2181,192.0.2.3:2181/marathon`

`sudo cp /etc/marathon/conf/master /etc/marathon/conf/zk`
Limpiar los registros que se tenian del slave con el siguiente comando:

```sudo rm -f /var/lib/mesos/meta/slaves/latest```

Se necesito de estos comando para levantar el slave con el master. 

```/usr/sbin/mesos-slave --master=zk://10.110.70.45:2181/mesos --log_dir=/var/log/mesos --hostname=10.110.70.170 --ip=10.110.70.170 --work_dir=/var/lib/mesos ```

Se creo un archivo

Comando utilizado para levantar el job en mesos

``` curl -X POST http://10.110.70.45:8080/v2/apps -d @app.json -H "Content-type: application/json"  ```
