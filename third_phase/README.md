Now we have a fully featured devops workstation. However we still have a ways to go.

What stops us from being able to kubectl our way to production is a lack of docker images.

Of course we could build all docker images on the bastion instance one time only...

That wouldn't be maintainable at all! We will set up gitlab CI/CD and build docker images that way.

We set up a single user gitlab instance to start. This instance is really gross, and runs a DB on it and everything!

Finally we crudely set up a single gitlab runner.

To finish off the third stage we push our repo into gitlab, triggering a cascade.

TODO:

Can we do export GITLAB_ROOT_PASSWORD with sudo?
