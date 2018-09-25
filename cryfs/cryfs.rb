class Cryfs < Formula
  desc "Cryptographic filesystem for the cloud"
  homepage "https://www.cryfs.org"
  url "https://github.com/cryfs/cryfs/releases/download/0.9.9/cryfs-0.9.9.tar.xz"
  sha256 "aa8d90bb4c821cf8347f0f4cbc5f68a1e0f4eb461ffd8f1ee093c4d37eac2908"

  head do
    url "https://github.com/cryfs/cryfs.git", branch: "develop"
    depends_on "libomp"
  end

  depends_on "boost"
  depends_on "cryptopp"
  depends_on "openssl"
  depends_on :osxfuse
  depends_on "cmake" => :build
  depends_on "python" => :build

  needs :cxx11

  def install
    ncpu = `sysctl -n hw.ncpu`.to_i
    mkdir("build") do
      system "cmake",
             "-DBUILD_TESTING=off",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DCRYFS_UPDATE_CHECKS=off",
             "-DOpenMP_CXX_FLAGS='-Xpreprocessor -fopenmp -I#{opt_include}'",
             "-DOpenMP_CXX_LIB_NAMES=omp",
             "-DOpenMP_omp_LIBRARY=#{opt_lib}/libomp.dylib",
             "..",
             *std_cmake_args
      system "make", "-j#{ncpu}"
      system "make", "install", "prefix=#{prefix}"
    end
  end

  test do
    ENV["CRYFS_FRONTEND"] = "noninteractive"
    assert_match "CryFS", shell_output("#{bin}/cryfs", 10)
  end
end
