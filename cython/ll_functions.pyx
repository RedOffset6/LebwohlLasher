# Import Cython
cimport numpy as np
import numpy as np
cimport numpy as cnp

# Define the one_energy_cy function
cpdef float one_energy_cy(np.ndarray[np.float64_t, ndim=2] arr, int ix, int iy, int nmax):
    cdef float en = 0.0
    cdef int ixp, ixm, iyp, iym
    ixp = (ix + 1) % nmax
    ixm = (ix - 1) % nmax
    iyp = (iy + 1) % nmax
    iym = (iy - 1) % nmax

    # Add together the 4 neighbor contributions to the energy
    cdef float ang
    ang = arr[ix, iy] - arr[ixp, iy]
    en += 0.5 * (1.0 - 3.0 * np.cos(ang)**2)
    ang = arr[ix, iy] - arr[ixm, iy]
    en += 0.5 * (1.0 - 3.0 * np.cos(ang)**2)
    ang = arr[ix, iy] - arr[ix, iyp]
    en += 0.5 * (1.0 - 3.0 * np.cos(ang)**2)
    ang = arr[ix, iy] - arr[ix, iym]
    en += 0.5 * (1.0 - 3.0 * np.cos(ang)**2)
    return en

# Define the all_energy_cy function
cpdef float all_energy_cy(np.ndarray[np.float64_t, ndim=2] arr, int nmax):
    cdef float enall = 0.0
    cdef int i, j
    for i in range(nmax):
        for j in range(nmax):
            enall += one_energy_cy(arr, i, j, nmax)
    return enall


cpdef float get_order_cy(cnp.float64_t[:, ::1] arr, int nmax):
    cdef cnp.float64_t[:, ::1] Qab = np.zeros((3, 3), dtype=np.float64)
    cdef cnp.float64_t[:, ::1] delta = np.eye(3, 3, dtype=np.float64)
    cdef cnp.float64_t[:, :, :] lab = np.empty((3, nmax, nmax), dtype=np.float64)

    cdef int a, b, i, j
    cdef float eigenvalues_max

    for a in range(3):
        for b in range(3):
            for i in range(nmax):
                for j in range(nmax):
                    lab[a, i, j] = 3.0 * np.cos(arr[i, j])

    for a in range(3):
        for b in range(3):
            for i in range(nmax):
                for j in range(nmax):
                    Qab[a, b] += lab[a, i, j] * lab[b, i, j] - delta[a, b]

    Qab = np.true_divide(Qab, 2.0 * nmax * nmax)

    cdef cnp.float64_t[::1] eigenvalues = np.linalg.eigvals(Qab)
    eigenvalues_max = eigenvalues.max()

    return eigenvalues_max