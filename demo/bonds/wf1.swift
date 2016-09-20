
import io;
import python;
import string;

string cuts[];
cuts[0] = "[]"; // Initially, just the Python empty list
steps = 3;

samples = 3;

(string energy) sim(int step, int sample, string c)
{
  energy = python_persist("import bonds_dummy1",
                          "bonds_dummy1.sim(%i, %i, \"%s\")" %
                          (step, sample, c));
}

(string cut) select_cut(string pairs)
{
  cut = python_persist("import bonds_dummy1",
                       "bonds_dummy1.select_cut(\"%s\")"%pairs);
}

// Step is indexed from 1, step 0 is the initial condition
foreach step in [1:steps]
{
  string pairs[];
  foreach sample in [0:samples-1]
  {
    pairs[sample] = sim(step, sample, cuts[step-1]);
  }
  // Pack all results into a Python tuple:
  cut_list = join(pairs, ",");
  printf("cut_list: %s", cut_list);
  cuts[step] = select_cut(cut_list);
}

printf("The optimal cut sequence is: %s", cuts[steps]);
