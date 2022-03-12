import sys, yaml
from pathlib import Path


if(Path(sys.argv[1]).is_file()):
    with open(sys.argv[1], 'r') as rf:
        ingress_controller_info = yaml.safe_load(rf)
    
    haproxy_ingress = list(filter(lambda r: r['spec']['selector']['run'] == 'haproxy-ingress', ingress_controller_info['resources'])).pop()
    http_port = list(filter(lambda p: p['port'] == 80, haproxy_ingress['spec']['ports'])).pop()
    node_port = http_port['nodePort']

    print(node_port)
