load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar", "pkg_deb")


pkg_tar(
    name = "onl-init-data",
    strip_prefix = "/src",
    package_dir = "/usr/local/sbin",
    srcs = ["//src:sbin"],
    mode = "0755",
)

pkg_tar(
    name = "debian-data",
    extension = "tar.gz",
    deps = [
        ":onl-init-data",
    ],
)

pkg_deb(
    name = "onl-init-debian",
    architecture = "amd64",
    built_using = "bazel",
    data = ":debian-data",
    depends = [
    ],
    description_file = "debian/description",
    homepage = "https://github.com/dhtech/onl-init",
    maintainer = "dhtech <root@local>",
    package = "dhtech-onl-init",
    version = "0.1",
    postinst = "debian/postinst.sh",
)
