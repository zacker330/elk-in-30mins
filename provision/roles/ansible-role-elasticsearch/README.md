# ansible-role-elasticsearch

[![Galaxy](http://img.shields.io/badge/galaxy-jonathanio.elasticsearch-blue.svg?style=flat-square)](https://galaxy.ansible.com/jonathanio/elasticsearch)

Ansible role to install and manage ElasticSearch, either standalone or part of the ELK cluster. All tested with test-kitchen and serverspec.

## Role Variables

These are the role-specific variables for configuring ElasticSearch:

| Variable | Purpose | Default |
| -------- | ------- | ------- |
| `elasticsearch_bind` | IP address to bind the service to | `127.0.0.1` |
| `elasticsearch_port_http` | HTTP port which exposes the standard API | `9200` |
| `elasticsearch_port_transport` | Inter-ES communication port for clustering | `9300` |
| `elasticsearch_heap_size` | Amount of memory to allocate to Java Heap | RAM/2 |
| `elasticsearch_node_name` | Name of the Node witin the Cluster | `{{ ansible_hostname }}` |
| `elasticsearch_cluster_name` | Name of the Cluster (common to all in Cluster) | `elasticsearch` |
| `elasticsearch_group_name` | Name of the Anisble group which is used to find all hosts in the cluster | `elasticsearch` |
| `elasticsearch_plugins_add` | Add the plugins listed to ElasticSearch | `[]` (None) |
| `elasticsearch_plugins_remove` | Remove the plugins listed from ElasticSearch | `[]` (None) |

## Generic Variables

These are generic variables which are common to many of the roles I produce:

| Variable | Purpose | Default |
| -------- | ------- | ------- |
| `squid_hostname` | Hostname of the internal Squid proxy for the private network | `Undefined` |
| `squid_port` | Port of the internal Squid proxy for the private network | `Undefined` |
| `use_firewalld` | If set to `yes`, iptables rules will be opened up using `firewalld` | `Undefined` |
| `use_ufw` | If set to `yes`, iptables rules will be opened up using `ufw` | `Undefined` |

## Example Playbook

```yaml
- hosts: elasticsearch
  roles:
     - { role: jonathanio.elasticsearch }
```

## License

This project is under the BSD License. See the `LICENSE` file for the full license text.

## Author Information

Jonathan Wright <jon@than.io>
