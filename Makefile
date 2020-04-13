all: tarball
	
tarball:
	git archive --format=tar HEAD | gzip > jenkins-in-house-plugins-build-flow-test-aggregator.tar.gz

.PHONY: all tarball
