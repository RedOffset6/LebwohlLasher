from LebwohlLasher import initdat, one_energy, all_energy, main
import numpy as np
input_matrix = np.array([[0.0, 1.0, 2.0], [1.0, 2.0, 3.0], [2.0, 3.0, 4.0]], dtype=np.float64)

print (all_energy(input_matrix))