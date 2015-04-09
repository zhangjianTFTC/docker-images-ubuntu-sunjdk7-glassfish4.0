FROM n3ziniuka5/ubuntu-oracle-jdk:14.10-JDK7
MAINTAINER zhangjian@tftiancai.com

RUN         apt-get update && \
            apt-get install -y curl unzip zip inotify-tools && \
            rm -rf /var/lib/apt/lists/*

#RUN         curl -L -o /tmp/glassfish-4.0.zip http://download.java.net/glassfish/4.0/release/glassfish-4.0.zip && \
#            unzip /tmp/glassfish-4.0.zip -d /usr/local && \
#            rm -f /tmp/glassfish-4.0.zip

ENV PATH /usr/local/glassfish4/bin:$PATH

ADD run.sh run.sh
ADD change_admin_password.sh change_admin_password.sh
ADD change_admin_password_func.sh change_admin_password_func.sh
ADD enable_secure_admin.sh enable_secure_admin.sh
ADD glassfish-4.0.zip /tmp/glassfish-4.0.zip
RUN         unzip /tmp/glassfish-4.0.zip -d /usr/local && \
            rm -f /tmp/glassfish-4.0.zip
RUN chmod +x .sh

# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener), 9009 (JPDA debug port)
EXPOSE 4848 8080 8181 9009
CMD [run.sh]