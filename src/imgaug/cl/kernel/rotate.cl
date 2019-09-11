
#define saturate_8u(value) ( (value) > 255 ? 255 : ((value) < 0 ? 0 : (value) ))
#define PI 3.14159265
#define RAD(deg) (deg * PI / 180)

__kernel void rotate_pln (  __global unsigned char* srcPtr,
                            __global unsigned char* dstPtr,
                            const float angleDeg,
                            const unsigned int source_height,
                            const unsigned int source_width,
                            const unsigned int dest_height,
                            const unsigned int dest_width,
                            const unsigned int channel
)
{
    float angleRad = RAD(angleDeg);
    float rotate[4];
    rotate[0] = cos(angleRad);
    rotate[1] = -1 * sin( angleRad);
    rotate[2] = sin( angleRad);
    rotate[3] = cos( angleRad);   

    int id_x = get_global_id(0);
    int id_y = get_global_id(1);
    int id_z = get_global_id(2);

    int xc = id_x - dest_width/2;
    int yc = id_y - dest_height/2;
    
    int k ;
    int l ;
   
    k = (int)((rotate[0] * xc )+ (rotate[1] * yc));
    l = (int)((rotate[2] * xc) + (rotate[3] * yc));
    k = k + source_width/2;
    l = l + source_height/2;
    if (l < source_height && l >=0 && k < source_width && k >=0 )
    dstPtr[(id_z * dest_height * dest_width) + (id_y * dest_width) + id_x] =
                            srcPtr[(id_z * source_height * source_width) + (l * source_width) + k];
    else
    dstPtr[(id_z * dest_height * dest_width) + (id_y * dest_width) + id_x] = 0;
    

}

__kernel void rotate_pkd (  __global unsigned char* srcPtr,
                            __global unsigned char* dstPtr,
                            const float angleDeg,
                            const unsigned int source_height,
                            const unsigned int source_width,
                            const unsigned int dest_height,
                            const unsigned int dest_width,
                            const unsigned int channel
)
{
    float angleRad = RAD(angleDeg);
    float rotate[4];
    rotate[0] = cos(angleRad);
    rotate[1] = -1 * sin( angleRad);
    rotate[2] = sin( angleRad);
    rotate[3] = cos( angleRad);

    int id_x = get_global_id(0);
    int id_y = get_global_id(1);
    int id_z = get_global_id(2);

    int xc = id_x - dest_width/2;
    int yc = id_y - dest_height/2;
    
    int k ;
    int l ;
   
    k = (int)((rotate[0] * xc )+ (rotate[1] * yc));
    l = (int)((rotate[2] * xc) + (rotate[3] * yc));
    k = k + source_width/2;
    l = l + source_height/2;
    
    if (l < source_height && l >=0 && k < source_width && k >=0 )
    dstPtr[id_z + (channel * id_y * dest_width) + (channel * id_x)] =
                             srcPtr[id_z + (channel * l * source_width) + (channel * k)];
    else
    dstPtr[id_z + (channel * id_y * dest_width) + (channel * id_x)] = 0;
    
}
