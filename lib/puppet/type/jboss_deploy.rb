Puppet::Type.newtype(:jboss_deploy) do
  @doc = "Deploys and undeploys EAR/WAR artifacts on JBoss Application Server"
  ensurable

  newparam(:name) do
    desc "The JNDI resource name."
    isnamevar
    isrequired
  end

  newparam(:source) do
    desc "Path to the EAR/WAR file."
  end

  newparam(:redeploy_on_refresh, :boolean => true) do
    desc "Force redeployment"
    defaultto true
  end

  newproperty(:servergroups, :array_matching => :all) do
    desc "Array of server groups on which deployment should be done"
  end

  newparam(:runasdomain, :boolean => true) do
    desc "Indicate that server is in domain mode"
    defaultto true
  end

  newparam(:runtime_name) do
    desc "Set the runtime-name"
    validate do |value|
      fail('Invalid file extension, module only supports: .jar, .war, .ear, .rar') if (value =~ /.+(\.ear|\.zip|\.war|\.jar)$/) == nil
    end
  end


  newparam(:controller) do
    desc "Domain controller host:port address"
    validate do |value|
      if value == nil or value.to_s == 'undef'
        raise ArgumentError, "Domain controller must be provided"
      end
    end
  end

  newparam :ctrluser do
    desc 'A user name to connect to controller'
  end

  newparam :ctrlpasswd do
    desc 'A password to be used to connect to controller'
  end

  newparam :retry do
    desc "Number of retries."
    defaultto 3
  end

  newparam :retry_timeout do
    desc "Retry timeout in seconds"
    defaultto 1
  end

  # Native method that triggers when resource is changed
  def refresh
    provider.redeploy_on_refresh
  end

end
