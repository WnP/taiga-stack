CREATE USER taiga WITH password 'taiga';
CREATE DATABASE taiga WITH OWNER taiga;
-- Now add user login in pool_passwd file by running the following command on pgpool node
--
-- pg_md5 --md5auth --username=taiga taiga
--
-- Now copy the last ligne in /etc/pgpool2/pool_passwd to /usr/local/etc/pool_passwd
--
-- Or you can also just append it to /usr/local/etc/pool_passwd:
--
-- echo 'taiga:md53f31c8e808d2f77fc1a7419b954df441' >> /usr/local/etc/pool_passwd
