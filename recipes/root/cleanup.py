#!/usr/bin/env python
import os

env_path = os.environ['PREFIX']

# Remove the symlinked directory that is used for padding the path
padded_env_path = os.path.join(env_path, 'symlink_for_root'+'_pad'*100)
padded_env_path = padded_env_path[:80]
os.remove(padded_env_path)
