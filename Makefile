all: tarball
	
tarball:
	git archive --format=tar HEAD | gzip > jenkins-in-house-plugins-build-flow-test-aggregator.tar.gz

clean:
	git fetch origin
	git reset --hard origin/SETI-4077-test
	rm -rf /root/rpmbuild/SOURCES/jenkins-in-house-plugins-build-flow-test-aggregator.tar.gz jenkins-in-house-plugins-build-flow-test-aggregator.tar.gz
	rm -rf /var/lib/juseppe/unz/*
	rm -rf /root/rpmbuild/SOURCES/jenkins-in-house-plugins-build-flow-test-aggregator.tar.gz 
	yum remove -y jenkins-in-house-plugins-build-flow-test-aggregator
	yum clean all

build:
	cp jenkins-in-house-plugins-build-flow-test-aggregator.tar.gz /root/rpmbuild/SOURCES/jenkins-in-house-plugins-build-flow-test-aggregator.tar.gz
	rpmbuild -ba build-flow-test-aggregator.spec

check:
	createrepo -v /root/rpmbuild/RPMS/x86_64/
	yum install jenkins-in-house-plugins-build-flow-test-aggregator
	mv /var/lib/juseppe/build-flow-test-aggregator.hpi /var/lib/juseppe/unz/
	unzip /var/lib/juseppe/unz/build-flow-test-aggregator.hpi -d /var/lib/juseppe/unz/
	cat /var/lib/juseppe/unz/META-INF/MANIFEST.MF

test:
	rpm2cpio /root/rpmbuild/RPMS/x86_64/jenkins-in-house-plugins-build-flow-test-aggregator-2.0.9-1.el7.x86_64.rpm | cpio -idmv
	unzip var/lib/juseppe/stork-pi-pool.hpi -d var/lib/juseppe/unz/
	cat var/lib/juseppe/unz/META-INF/MANIFEST.MF

.PHONY: all tarball clean test build check
