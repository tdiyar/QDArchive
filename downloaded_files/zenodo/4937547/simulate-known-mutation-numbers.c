#include "/home/eang33/libhdr"
/* Compile with
gcc -O2 -o simulate-known-mutation-numbers simulate-known-mutation-numbers.c /home/eang33/genlib.c -lm -lgsl -lgslcblas
*/

#define max_str_len 200
#define max_mut_categories 10

get_int_parameter(char *config_file, int *parm, char *str)
{
   FILE *infile;
   char instring[100];
   int stat, x;
   infile = openforreadsilent(config_file);
   for (;;)
   {
      stat =fscanf(infile, "%s", instring);
      if ((stat == EOF) || (stat != 1))
         gabort("Read error 1: get_int_parameter stat=", stat);
//      printf("instring %s\n", instring);
      if (strcmp(instring, str) == 0)
      {
         stat =fscanf(infile, "%d", &x);
         if ((stat == EOF) || (stat != 1))
            gabort("Read error 1: get_int_parameter stat=", stat);
         *parm = x;
         fclose(infile);
         return;
      }
      else skiptoendofline(infile);
   }
   gabort("Read error 2: get_int_parameter", 0);
}

get_double_parameter(char *config_file, double *parm, char *str)
{
   FILE *infile;
   char instring[100];
   int stat;
   double x;
   infile = openforreadsilent(config_file);
   for (;;)
   {
      stat =fscanf(infile, "%s", instring);
      if ((stat == EOF) || (stat != 1))
         gabort("Read error 1: get_int_parameter stat=", stat);
//      printf("instring %s\n", instring);
      if (strcmp(instring, str) == 0)
      {
         stat =fscanf(infile, "%lf", &x);
         if ((stat == EOF) || (stat != 1))
            gabort("Read error 1: get_int_parameter stat=", stat);
         *parm = x;
         fclose(infile);
         return;
      }
      else skiptoendofline(infile);
   }
   gabort("Read error 2: get_int_parameter", 0);
}


form_string(char *res_str, char *str, int i)
{
   char i_str[100];
   strcpy(res_str, str);
   sprintf(i_str, "%d", i);
   strcat(res_str, i_str);
}


read_config_file(char *config_file, double *mean_mutations, int *n_obs, int *reps,
   int *n_mut_categories, double *p_d, double *s_d, double *v_e, double *p_0)
{
   int i;
   char temp_str[100];
   get_double_parameter(config_file, mean_mutations, "mean_mutations");
   get_int_parameter(config_file, n_obs, "n_obs");
   get_int_parameter(config_file, reps, "reps");
   get_int_parameter(config_file, n_mut_categories, "n_mut_categories");
   if (*n_mut_categories >= max_mut_categories)
      gabort("n_mut_categories >= max_mut_categories", *n_mut_categories);
   for (i=0; i<*n_mut_categories; i++)
   {
      form_string(temp_str, "p_d_", i);
      get_double_parameter(config_file, &(p_d[i]), temp_str);
      form_string(temp_str, "s_d_", i);
      get_double_parameter(config_file, &(s_d[i]), temp_str);
   }
   get_double_parameter(config_file, v_e, "v_e");
   get_double_parameter(config_file, p_0, "p_0");
}


simulate_data(char *outfile_name, double mean_mutations, int n_obs, int reps, double *p_d,
   double *s_d, double v_e, double p_0, int n_mut_categories)
{
   FILE *outfile;
   int i, j, k, n;
   double u, Xi, e, cum_p_d[max_mut_categories];
   for (i=0; i<n_mut_categories; i++)
   {
      cum_p_d[i] = p_d[i];
      if (i > 0) cum_p_d[i] += cum_p_d[i-1];
      printf("cum_p_d[%d] %lf\n", i, cum_p_d[i]);
   }
//   monitorinput();
   outfile = openforwrite(outfile_name, "w");
   for (i=1; i<=n_obs; i++)
   {
      Xi = 1.0;
      u = uniform();
      if (u < p_0)
      {
         n = 0;
      }
      else
      {
         n = genpoisson(mean_mutations);
      }
      for (j=1; j<=n; j++)
      {
         u = uniform();
         for (k=0; k<n_mut_categories; k++)
         {
            if (u < cum_p_d[k])
            {
               Xi += s_d[k];
               break;
            }
         }
      }
//      printf("n %d e %lf Xi %lf\n", n, e, Xi);
      for (j=1; j<=reps; j++)
      {
         e = normal(0.0, sqrt(v_e));
         Xi += e;
         fprintf(outfile, "%d %d %lf\n", i, n, Xi);
      }
   }
   fclose (outfile);
}


print_usage_str(char *argv[])
{
   printf("Usage:  $ %s output-file config-file\n", argv[0]);
}


main(int argc, char *argv[])
{
   int n_command_line_param, i;
   double mean_mutations, p_d[max_mut_categories], s_d[max_mut_categories], v_e, p_0;
   int n_obs, reps, n_mut_categories;
   getseedquick("seedfile");
   n_command_line_param = argc;
   printf("n_command_line_param %d\n", n_command_line_param);
   if (n_command_line_param != 3)
   {
      print_usage_str(argv);
      gabort("n_command_line_param != 2:", n_command_line_param);
   }
   printf("Config file = %s output file %s\n", argv[2], argv[1]);
   read_config_file(argv[2], &mean_mutations, &n_obs, &reps, &n_mut_categories, p_d, s_d,
      &v_e, &p_0);
   printf("Output file = %s mean_mutations = %lf n_obs = %d reps %d v_e %lf p_0 %lf\n",
      argv[1], mean_mutations, n_obs, reps, v_e, p_0);
   for (i=0; i<n_mut_categories; i++)
   {
      printf("p_d[%d] %lf s_d[%d] %lf\n", i, p_d[i], i, s_d[i]);
   }
//   monitorinput();
   simulate_data(argv[1], mean_mutations, n_obs, reps, p_d, s_d, v_e, p_0, n_mut_categories);
   writeseed("seedfile");
}
