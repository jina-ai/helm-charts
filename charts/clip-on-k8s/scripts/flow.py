from jina import Flow


f = Flow(protocol='http', port=51000, monitoring=True) \
    .add(name='clip_encoder',
         uses='docker://jinaai/clip_executor:master',
         replicas=2,
         uses_with={'name': 'ViT-B/16', 'device': 'cpu', 'minibatch_size': 64})

f.to_k8s_yaml('./clip_k8s_flow', k8s_namespace='jina-clip-as-service')
