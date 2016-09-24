Logstash
========

Ansible role to install and configure Logstash.

This role has been tested with Logstash v2.2 only

*Note:* Logstash requires Java 1.7+

## Examples

```
- hosts: loghost

  vars:
    logstash_version: 2.2
    logstash_input_configs: 
      - |
        file { 
                path => ["/var/log/nginx/access.log"]
            }
    logstash_output_configs: 
      - |
        stdout { 
                codec => rubydebug
            }
      - |
        elasticsearch { 
                hosts => ["localhost:9200"] 
            }

  roles:
    - wunzeco.logstash
```

## Dependencies:

None
