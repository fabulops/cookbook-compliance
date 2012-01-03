DESCRIPTION
===========

This cookbook is an attempt to add some minimal compliance and audit
capabilities to nodes. Please note that this cookbook is not intended to
replace host-based IDS systems, such as OSSEC. It is intended to be
combined with the reporting handlers in chef to alert ops of accidental
changes to the system outside of any cookbook managed resources.

Requirements
------------

This cookbook is being developed against Chef 0.10.x

Platforms
---------

This cookbook is being developed against Ubuntu 10.04.3 LTS. Other
platforms may be added if time and resources permit.

Recipes
-------

*compliance::default*

The default recipe will identify the platform and include the relevant
driver recipe. If a platform is not supported, the following will be
printed in the output of _chef-client_:

    DEBUG: Compliance:: Unsupported Platform

Attributes
----------

*[:compliance][:ignore]* - Array of files and directories to exempt from
compliance checking.

*[:compliance][:failure]* - This is set to 'true' if any compliance
checks indicate failure on a run. This provides a way to poll any nodes
that are currently out of compliance:

    knife search node 'compliance_failure:true'

Resources
---------

This cookbook comes with an _audit_ resource. Some examples of its use
are as follows:

    audit "/tmp" do
      resource "directory"
      owner "root"
      group "root"
      mode "1777"
    end

    audit "/usr/bin/passwd" do
      resource "file"
      owner "root"
      group "root"
      mode  "4755"
    end

If an audited resource does not match its signature, the following log
will be printed in the output of _chef-client_:

    WARN: Compliance::Failure <resource>

Also, if an audited resource does not exist, a compliance check will not
be performed and no action will be taken.

Finally, Chef will make sure the desired state is set. If you make
local changes to files covered by this cookbook, add the full paths to
*node[:compliance][:ignore]* and they will not be brought into
compliance.

For example, if you administratively change */usr/bin/passwd*, adding:

    "compliance": {
      "ignore": [
        "/usr/bin/passwd"
      ]
    }

to the node will prevent this cookbook from taking action. Additional
files and directories can be added to the attribute array as needed.
Ignored resources will be reflected in the output of _chef-client_ with
the following warning:

    WARN: Compliance::Ignore <resource>

LICENSE AND AUTHOR
==================

Author:: Adam Garside (<adam.garside@gmail.com>)

Copyright 2009-2012, Adam Garside

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
