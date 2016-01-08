+++ date = "2015-12-20 07:49:00+00:00" title = "Color coding your processes" type = "post" tags = ["bash"] categories = ["code"] description = "HOw to make your variables stand out from values in bash for processes" keywords = ["bash", "process", "linux terminal", "terminal", "process colors"] draft = "true"+++




ps -ef | egrep boxcoll | head -1  | awk 'BEGIN {RS="--"}{print $0}' | awk '{printf "\033[40;38;5;82m  %-30s  \033[38;5;198m %s \033[0m \n", $1, $2 }'





[ dev ]@csqdev-web01 ~ $ ps -ef | egrep uwsgi | egrep touch | head -1 | awk 'BEGIN {RS="--"; FS="="; ORS="\n\t--"} {printf "\033[40;38;5;82m  %s \033[38;5;198m %s \033[0m \n", $1, $2 }'
  grass-py  10332  
  --daemonize  /var/log/uwsgi/uwsgi-risk.log  
  --log-prefix    
  --master    
  --reaper    
  --show-config    
  --pidfile  /var/run/uwsgi/uwsgi-risk.pid  
  --socket  /var/run/uwsgi/uwsgi-risk.sock  
  --chmod-socket    
  --processes  16  
  --uid  grass-py  
  --gid  dev  
  --module  wsgi  
  --pythonpath  /usr/local/pygh/current/pygh  
  --virtualenv  /opt/py27env  
  --chdir  /usr/local/pygh/current/pygh/conf  
  --env  LD_LIBRARY_PATH=:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/../vendor/unix/linux-x86_64/solace-ccsmp-7.0.0.85/solclient/lib:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/_run/lib/python2.7/site-packages:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/_run/lib64/python2.7/site-packages  
  --env  PYTHONPATH=:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/../vendor/unix/scilin6-x86_64/python/lib/python2.7/site-packages:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/.:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/_run/lib/python2.7/site-packages:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/_run/lib64/python2.7/site-packages:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/./external/simplejson-2.1.0:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/./external/python-memcached-1.45:/usr/local/pygh/pygh.Scientific.6.pyghweb-2015.12.004/pygh/./external/JSON.minify  
  --env  PYTHON_EGG_CACHE=/usr/local/pygh/current/tmp  
  --touch-reload  /usr/local/pygh/current/pygh/conf/wsgi.py  
  --reload-on-as=800    
  --reload-on-rss=200    
      
