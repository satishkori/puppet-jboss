# Internal define - register module layer
define jboss::internal::module::registerlayer (
  $layer = name,
) {
  include jboss
  include jboss::internal::params

  File {
    mode   => '0640',
    owner  => $jboss::jboss_user,
    group  => $jboss::jboss_group,
  }

  if (!defined(Exec["jboss::module::layer::${layer}"])) {
    $command_1 = "awk -F'=' 'BEGIN {ins = 0} /^layers=/ { ins = ins + 1; print \$1=${layer},\$2 } END "
    $command_2 = "{if(ins == 0) print \"layers=${layer},base\"}' > ${jboss::home}/modules/layers.conf"
    exec { "jboss::module::layer::${layer}":
      command => "${command_1}${command_2}",
      unless  => "egrep -e '^layers=.*${layer}.*' ${jboss::home}/modules/layers.conf",
      path    => $jboss::internal::params::syspath,
      user    => $jboss::jboss_user,
      require => Anchor['jboss::installed'],
      notify  => Service[$jboss::product],
    }
    file { "${jboss::home}/modules/system/layers/${layer}":
      ensure  => 'directory',
      alias   => "jboss::module::layer::${layer}",
      require => Anchor['jboss::installed'],
      notify  => Service[$jboss::product],
    }
  }
}
