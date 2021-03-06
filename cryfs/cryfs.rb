class Cryfs < Formula
  desc "Cryptographic filesystem for the cloud"
  homepage "https://www.cryfs.org"
  url "https://github.com/cryfs/cryfs/releases/download/0.10.2/cryfs-0.10.2.tar.xz"
  sha256 "5531351b67ea23f849b71a1bc44474015c5718d1acce039cf101d321b27f03d5"

  head do
    url "https://github.com/cryfs/cryfs.git", branch: "develop", :shallow => false
  end

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libomp"
  depends_on "openssl"
  depends_on :osxfuse

  def install
    libomp = Formula['libomp']
    configure_args = [
      "-DBUILD_TESTING=off",
      "-DCMAKE_BUILD_TYPE=Release",
      "-DCRYFS_UPDATE_CHECKS=off",
      "-DOpenMP_CXX_FLAGS='-Xpreprocessor -fopenmp -I#{libomp.include}'",
      "-DOpenMP_CXX_LIB_NAMES=omp",
      "-DOpenMP_omp_LIBRARY=#{libomp.lib}/libomp.dylib"
    ]
    ncpu = `sysctl -n hw.ncpu`.to_i
    mkdir("build") do
      system "cmake", *configure_args, *std_cmake_args, ".."
      system "make", "-j#{ncpu}"
      system "make", "install", "prefix=#{prefix}"
    end
  end

  test do
    ENV["CRYFS_FRONTEND"] = "noninteractive"

    # Test showing help page
    assert_match "CryFS", shell_output("#{bin}/cryfs 2>&1", 10)

    # Test mounting a filesystem. This command will ultimately fail because homebrew tests
    # don't have the required permissions to mount fuse filesystems, but before that
    # it should display "Mounting filesystem". If that doesn't happen, there's something
    # wrong. For example there was an ABI incompatibility issue between the crypto++ version
    # the cryfs bottle was compiled with and the crypto++ library installed by homebrew to.
    mkdir "basedir"
    mkdir "mountdir"
    assert_match "Operation not permitted", pipe_output("#{bin}/cryfs -f basedir mountdir 2>&1", "password")
  end
end
