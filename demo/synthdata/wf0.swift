
import io;

app (file o) dd(file i, string args[])
{
  "dd" args ("if="+filename(i)) ("of="+filename(o));
}

string a[] = [ "bs=1M" ];
file f1 = input("chunk-1K.data");
file f2<"out.data"> = dd(f1, a);
