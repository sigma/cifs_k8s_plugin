## Build & Package Kubernetes cifs plugin with Dockerception

Provide a Kubernetes cifs for CoreOS (for example) to use, optimized for speed.

### Delivering plugin to a docker host:

Kubernetes:

```bash
docker run -it --rm -v /etc/kubernetes/volumeplugins/hodique.info~cifs:/target sigma/cifs_k8s_plugin /target
```

Openshift:

```bash
docker run -it --rm -v /usr/libexec/kubernetes/kubelet-plugins/volume/exec/hodique.info~cifs:/target sigma/cifs_k8s_plugin /target
```

After installing the plugin, restart the kubelet or the origin-node service so that the plugin is detected.

### Sample usage

Assuming a `//192.168.56.101/TEST` cifs share, accessible by a `TESTER` user with a `SECRET` password.

1. create secret to access the cifs share

```sh
kubectl create secret generic cifscreds --from-literal username=TESTER --from-literal password=SECRET
```

2. create the cifs-enabled pod

```sh
cat <<EOF | tee pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: cc
spec:
  containers:
  - name: cc
    image: nginx
    volumeMounts:
    - name: test
      mountPath: /data
    ports:
    - containerPort: 80
  volumes:
  - name: test
    flexVolume:
      driver: "hodique.info/cifs"
      secretRef:
        name: cifscreds
      readOnly: true
      options:
        source: "//192.168.56.101/TEST"
        mountOptions: "dir_mode=0700,file_mode=0600"
EOF
```

Feel free to edit the flexVolume specification to match your needs.

3. run the pod

```sh
kubectl create -f pod.yml
```

4. verify the pod

```sh
kubectl get pod cc
kubectl exec cc -- ls -l /data
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
