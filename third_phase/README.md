Now we have a fully featured devops workstation. However we still have a ways to go.

What stops us from being able to kubectl our way to production is a lack of docker images.

Of course we could build all docker images on the bastion instance one time only...

That wouldn't be maintainable at all! We will set up gitlab CI/CD and build docker images that way.