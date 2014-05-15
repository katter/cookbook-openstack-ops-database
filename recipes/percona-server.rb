# encoding: UTF-8
#
# Cookbook Name:: openstack-ops-database
# Recipe:: mysql-server
#
# Copyright 2013, Opscode, Inc.
# Copyright 2012-2013, Rackspace US, Inc.
# Copyright 2013, AT&T Services, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class ::Chef::Recipe # rubocop:disable Documentation
  include ::Openstack
end

db_endpoint = endpoint 'db'

node.override['percona']['server']['bind_address'] = db_endpoint.host
node.override['percona']['server']['innodb_thread_concurrency'] = '0'
node.override['percona']['server']['innodb_commit_concurrency'] = '0'
node.override['percona']['server']['innodb_read_io_threads'] = '4'
node.override['percona']['server']['innodb_flush_log_at_trx_commit'] = '2'
node.override['percona']['server']['skip-name-resolve'] = true

include_recipe 'openstack-ops-database::percona-client'
include_recipe 'percona::server'

