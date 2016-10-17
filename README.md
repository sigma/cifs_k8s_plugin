## Build & Package Kubernetes cifs plugin with Dockerception

Provide a Kubernetes cifs for CoreOS (for example) to use, optimized for speed.

### Delivering plugin to a docker host:

```bash
docker run -it --rm -v /etc/kubernetes/volumeplugins/hodique.info~cifs:/target sigma/cifs_k8s_plugin /target
```

### Docker building dockers - keeping them small

docker build process split into a 'builder' docker and a 'runtime' 
docker to keep final docker image as small as possible.

To build the runtime docker image, clone this project and then
run the following command:

```bash
$ make container
```

### References:

- https://github.com/coreos/coreos-overlay/issues/595
- https://github.com/jamiemccrindle/dockerception

*NOTE*: this repository cannot be built automatically by docker hub.
