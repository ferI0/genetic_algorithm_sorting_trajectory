/*
 *Expects two sorted arrays !!!
 *
 *Example:
 * >>ismember_mex( [1 3 5], [1 2 3 4 6 7 8] )
 *ans =

     1
     1
     0
 */

#include <matrix.h>
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
    double *in1, *in2;
    mxLogical *out;
    int N;
    
    in1 = mxGetPr(prhs[0]);
    in2 = mxGetPr(prhs[1]);
    
    N = (int)mxGetNumberOfElements(prhs[0]);
    
    plhs[0] = mxCreateLogicalMatrix( N,1 );
    out = mxGetLogicals( plhs[0] );
    
    for( N+=(int)mxGetNumberOfElements(prhs[1]); N>0; N--){
        if( *in1 <= *in2 ){ /*is / is not member*/
            *out++=(*in1++ == *in2); 
        }else{  /*keep looking*/
            in2++;
        }
    }
}