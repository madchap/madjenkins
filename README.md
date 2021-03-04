# Update plugin version in txt file
https://github.com/jenkinsci/docker#updating-plugins-file-preview

but effectively

```
JENKINS_IMAGE=jenkins/jenkins
docker run -it ${JENKINS_IMAGE} bash -c "stty -onlcr && jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt --available-updates --output txt" >  plugins2.txt
mv plugins2.txt plugins.txt
```

seems to work well :)

# Build and run
```
$ docker build -t madchap/jenkins:latest .
$ docker run --rm -p 8080:8080 madchap/jenkins
```
