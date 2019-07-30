# Credit: https://github.com/Homebrew/homebrew-core/pull/28480
class Duktape < Formula
  desc "Embeddable Javascript engine with compact footprint"
  homepage "https://duktape.org"
  url "https://duktape.org/duktape-2.4.0.tar.xz"
  sha256 "86a89307d1633b5cedb2c6e56dc86e92679fc34b05be551722d8cc69ab0771fc"

  def install
    make_args = ["-f", "Makefile.sharedlibrary"]
    make_install_args = ["INSTALL_PREFIX=#{prefix}", *make_args]
    system "make", *make_args
    system "make", *make_install_args, "install"
  end

  test do
    (testpath/"test.cc").write <<~EOS
      #include <stdio.h>
      #include \"duktape.h\"
      int main(int argc, char *argv[]) {
        duk_context *ctx = duk_create_heap_default();
        duk_eval_string(ctx, \"1+2\");
        printf(\"1+2=%d\\n\", (int) duk_get_int(ctx, -1));
        duk_destroy_heap(ctx);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "-lduktape", testpath/"test.cc", "-o", testpath/"test"
    assert_equal "1+2=3", shell_output(testpath/"test").strip, "Duktape can add number"
  end
end
