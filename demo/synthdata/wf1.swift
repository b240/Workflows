
import io;
import sys;

app (file o) dd(file i, string args[])
{
  "dd" args ("if="+filename(i)) ("of="+filename(o));
}

M = parseInt(argv("M"));
N = parseInt(argv("N"));
F = argv("F");

string a[] = [ "bs=100M" ];

file f[][];
f[0][0] = input(F);

for (int j = 1; j < M; j = j+1)
{
  file t<"f-%i-%i.data"%(0,j)> = dd(f[0][0], a);
  f[0][j] = t;
}

for (int i = 1; i < N; i = i+1)
{
  for (int j = 0; j < M; j = j+1)
  {
    file t<"f-%i-%i.data"%(i,j)> = dd(f[i-1][j], a);
    f[i][j] = t;
  }
}
