import numpy as np
from LebwohlLasher_Numba import initdat, one_energy, all_energy, main, get_order
import pytest

@pytest.mark.parametrize("input_arr, expected_energy", [
    (np.array([[0.0, 1.0, 2.0], [1.0, 2.0, 3.0], [2.0, 3.0, 4.0]], dtype=np.float64), 4.373435645621068),
    (np.array([[0.0, 1.0, 2.0], [1.0, 2.0, 3.0], [2.0, 3.0, 4.0]], dtype=np.float64), 4.373435645621068),
    (np.array([[0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]], dtype=np.float64), -36.0),
    (np.array([[1.0, 1.0, 1.0], [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]], dtype=np.float64), -36.0),
    (np.array([[0.1, 0.2, 0.3], [0.2, 0.3, 0.4], [0.3, 0.4, 0.5]], dtype=np.float64), -34.930747347168314),
    (np.array([[1.0, 0.0, 0.0], [0.0, 2.0, 0.0], [0.0, 0.0, 3.0]], dtype=np.float64), -17.342278975437672),
])
def test_all_energy(input_arr, expected_energy):
    nmax = input_arr.shape[0]
    calculated_energy = all_energy(input_arr, nmax)
    assert calculated_energy == expected_energy

@pytest.mark.parametrize("input_arr, ix, iy, nmax, expected_energy", [
    (np.array([[0.0, 1.0, 2.0], [1.0, 2.0, 3.0], [2.0, 3.0, 4.0]], dtype=np.float64), 1, 1, 3, 0.24844050964142683),
    (np.array([[0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]], dtype=np.float64), 0, 0, 3, -4.0),
    (np.array([[1.0, 1.0, 1.0], [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]], dtype=np.float64), 1, 1, 3, -4.0 ),
    (np.array([[0.1, 0.2, 0.3], [0.2, 0.3, 0.4], [0.3, 0.4, 0.5]], dtype=np.float64), 2, 2, 3, -3.85169135776619),
    (np.array([[1.0, 0.0, 0.0], [0.0, 2.0, 0.0], [0.0, 0.0, 3.0]], dtype=np.float64), 0, 0, 3, 0.24844050964142683),
])
def test_one_energy(input_arr, ix, iy, nmax, expected_energy):
    calculated_energy = one_energy(input_arr, ix, iy, nmax)
    assert calculated_energy == expected_energy


@pytest.mark.parametrize("input_arr, nmax, expected_order", [
    (np.array([[0.0, 1.0, 2.0], [1.0, 2.0, 3.0], [2.0, 3.0, 4.0]], dtype=np.float64), 3, 0.2523437843403505),
    (np.array([[0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]], dtype=np.float64), 3, 1.0),
    (np.array([[1.0, 1.0, 1.0], [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]], dtype=np.float64), 3, 1.0),
    (np.array([[0.1, 0.2, 0.3], [0.2, 0.3, 0.4], [0.3, 0.4, 0.5]], dtype=np.float64), 3, 0.9801990249475614),
    (np.array([[1.0, 0.0, 0.0], [0.0, 2.0, 0.0], [0.0, 0.0, 3.0]], dtype=np.float64), 3, 0.7409789212702145),
])
def test_get_order(input_arr, nmax, expected_order):
    calculated_order = get_order(input_arr, nmax)
    assert calculated_order == expected_order