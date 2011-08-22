define pxe::images::centos(
    $arch,
    $ver,
    $os,
    $baseurl = ''
  ) {

  $tftp_root = $::pxe::tftp_root

  if $baseurl == '' {
    $srclocation = "http://mirrors.kernel.org/$os/$ver/os/$arch/images/pxeboot"
  } else {
    $srclocation = inline_template($baseurl)
  }

  exec {
    "wget $os pxe linux $arch $ver":
      path    => ["/usr/bin", "/usr/local/bin"],
      cwd     => "$tftp_root/images/$os/$ver/$arch",
      creates => "$tftp_root/images/$os/$ver/$arch/vmlinuz",
      command => "wget $srclocation/vmlinuz";
    "wget $os pxe initrd.img $arch $ver":
      path    => ["/usr/bin", "/usr/local/bin"],
      cwd     => "$tftp_root/images/$os/$ver/$arch",
      creates => "$tftp_root/images/$os/$ver/$arch/initrd.img",
      command => "wget $srclocation/initrd.img";
  }

}
