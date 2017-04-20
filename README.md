# mesos_script

## Instalación de mesos.

Se realizará la instalación de mesos y   marathon.

```sudo yum -y install mesos marathon ```

Installar zookeeper

``` sudo yum -y install mesosphere-zookeeper```


## Configuración MESOS- MASTER

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


``` sudo cp /etc/marathon/conf/master /etc/marathon/conf/zk ```

Antes 

```zk://192.0.2.1:2181,192.0.2.2:2181,192.0.2.3:2181/mesos```

Después

``` zk://192.0.2.1:2181,192.0.2.2:2181,192.0.2.3:2181/marathon```

Para verificar que el mesos ha sido configurado correctamente, es necesario levantar `zookeeper`, `mesos-master` y `marathon`

```sudo systemctl start zookeeper ```
```sudo systemctl start mesos-master``` 
```dudo systemctl start marathon```

En un navagador web verificar el mesos el puerto `5050` 

```http://10.110.70.45:5050/ ```

EN un navegador web verificar marathon en el puerto  `8080`

```http://10.110.70.45:8080 ```


## Configuración MESOS-SLAVE

Se detendrá `zookeeper`

``` sudo systemctl stop zookeeper```

Se necesita el IP y el hostname de los nodos que se usarán como slaves.

```echo 10.110.70.170 | sudo tee /etc/mesos-slave/ip``` 
```sudo cp /etc/mesos-slave/ip /etc/mesos-slave/hostname``` 

Limpiar los registros que se tenian del slave con el siguiente comando:

```sudo rm -f /var/lib/mesos/meta/slaves/latest```

Se necesito de estos comando para levantar el slave con el master. 

```/usr/sbin/mesos-slave --master=zk://10.110.70.45:2181/mesos --log_dir=/var/log/mesos --hostname=10.110.70.170 --ip=10.110.70.170 --work_dir=/var/lib/mesos ```



## Task Mesos

Se realizó un bash para verificar cuanto tiempo se tardaba en realizar un job. El bash se encuentra en el repositorio `new.bash`


Para levantar el job, se creo un archivo json con las espeficicaciones de la aplicación que se desplegará en mesos.

El archivo se encuentra en el repositorio con el nombre de `app.json` y el comando para levantar el job es el siguiente

``` curl -X POST http://10.110.70.45:8080/v2/apps -d @app.json -H "Content-type: application/json"  ```

## Resultados

Nombre_prueba      CPU     Mems     Instancia   Tiempo

test1		   1       32          1         15 
test2              1       16          2         21
test3              4       16          1         15
test_maquina_bash  -       -           -          78                                       

