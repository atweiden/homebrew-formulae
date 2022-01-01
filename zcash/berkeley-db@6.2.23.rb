class BerkeleyDbAT6223 < Formula
  desc "High performance key/value database"
  homepage "https://www.oracle.com/database/technologies/related/berkeleydb.html"
  url "https://download.oracle.com/berkeley-db/db-6.2.23.tar.gz"
  sha256 "47612c8991aa9ac2f6be721267c8d3cdccf5ac83105df8e50809daea24e95dc7"
  license "Sleepycat"

  keg_only :versioned_formula

  # see: zcash/zcash/depends/packages/bdb.mk
  patch do
    url "https://github.com/zcash/zcash/raw/ba4b4791c12b7e3d97148f413dfd3c549e73c335/depends/patches/bdb/clang-12-stpcpy-issue.diff"
    sha256 "ee6189159aae0019fa284f67920953dcdf53750906fda81630f5148a03284252"
  end
  patch do
    url "https://github.com/zcash/zcash/raw/ba4b4791c12b7e3d97148f413dfd3c549e73c335/depends/patches/bdb/winioctl-and-atomic_init_db.patch"
    sha256 "543b02db86282c0dd1fb061920a4e662df6dbca811ee9421d982e6b7f72fbb71"
  end

  def install
    ENV.append "CXXFLAGS", "-std=c++17"
    ENV.append "LDFLAGS", "-static-libstdc++"
    ENV.append "LDFLAGS", "-lc++abi"

    # BerkeleyDB dislikes parallel builds
    ENV.deparallelize

    args = %W[
      --prefix=#{prefix}
      --mandir=#{man}
      --disable-replication
      --disable-shared
      --enable-cxx
      --enable-option-checking
    ]

    # BerkeleyDB requires you to build everything from the build_unix subdirectory
    cd "build_unix" do
      system "../dist/configure", *args

      system "make", "libdb_cxx-6.2.a", "libdb-6.2.a"
      system "make", "install"

      # use the standard docs location
      doc.parent.mkpath
      mv prefix+"docs", doc
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <assert.h>
      #include <string.h>
      #include <db_cxx.h>
      int main() {
        Db db(NULL, 0);
        assert(db.open(NULL, "test.db", NULL, DB_BTREE, DB_CREATE, 0) == 0);

        const char *project = "Homebrew";
        const char *stored_description = "The missing package manager for macOS";
        Dbt key(const_cast<char *>(project), strlen(project) + 1);
        Dbt stored_data(const_cast<char *>(stored_description), strlen(stored_description) + 1);
        assert(db.put(NULL, &key, &stored_data, DB_NOOVERWRITE) == 0);

        Dbt returned_data;
        assert(db.get(NULL, &key, &returned_data, 0) == 0);
        assert(strcmp(stored_description, (const char *)(returned_data.get_data())) == 0);

        assert(db.close(0) == 0);
      }
    EOS
    flags = %W[
      -I#{include}
      -L#{lib}
      -ldb_cxx
    ]
    system ENV.cxx, "test.cpp", "-o", "test", *flags
    system "./test"
    assert_predicate testpath/"test.db", :exist?
  end
end
