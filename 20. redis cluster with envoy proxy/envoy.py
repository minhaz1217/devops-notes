import jinja2
template = open('envoy.yaml.j2').read()
config = jinja2.Template(template).render(num_redis_hosts = 3)
envoy_yaml = open('envoy.yaml', 'w')
envoy_yaml.write(config)