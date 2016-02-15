
import assert;
import files;
import io;
import string;
import sys;
import unix;

import lammps;

main
{
  data_directory = argv("data");
  assert(file_exists(data_directory),
         "data directory not found: " + data_directory);

  file inputs[] = glob(data_directory/"input-*.inp");

  foreach i in inputs
  {
    printf("input: %s", filename(i));
    lammps_args = "-i " + filename(i);
    @par=1 lammps(data_directory, lammps_args);
  }
}
