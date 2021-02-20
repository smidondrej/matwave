function tests = test_rle
    tests = functiontests(localfunctions);
end

function setupOnce(tc)
    l = 3;
    h = 4;
    idx = zeros(l,h);
    for i=1:l*h
        idx(floor((i-1)/h)+1,mod((i-1),h)+1) = i;
    end
    tc.TestData.rows = l;
    tc.TestData.cols = h;
	tc.TestData.matrix = idx;
    tc.TestData.array = [1,2,5,9,6,3,4,7,10,11,8,12];
    tc.TestData.string = [1,1,1,2,2,3,4,4];
    tc.TestData.code = [1,2,3,4];
    tc.TestData.cnt = uint8([3,2,1,2]);
end

function test_zigzag(tc)
    test_array = matwave.rle.zigzag(tc.TestData.matrix);
    tc.verifyEqual(tc.TestData.array, test_array);
end

function test_izigzag(tc)
    test_matrix = matwave.rle.izigzag(tc.TestData.array, tc.TestData.rows, tc.TestData.cols);
    tc.verifyEqual(tc.TestData.matrix, test_matrix);
end

function test_encode(tc)
    [test_code, test_cnt] = matwave.rle.encode(tc.TestData.string);
    tc.verifyEqual(tc.TestData.code', test_code);
    tc.verifyEqual(tc.TestData.cnt', test_cnt);
end

function test_decode(tc)
    test_string = matwave.rle.decode(tc.TestData.code, tc.TestData.cnt);
    tc.verifyEqual(tc.TestData.string, test_string);
end

function test_code(tc)
    tmp_array = matwave.rle.zigzag(tc.TestData.matrix);
    [tmp_code, tmp_cnt] = matwave.rle.encode(tmp_array);
    tmp_string = matwave.rle.decode(tmp_code, tmp_cnt);
    tmp_matrix = matwave.rle.izigzag(tmp_string, tc.TestData.rows, tc.TestData.cols);
    tc.verifyEqual(tc.TestData.matrix, tmp_matrix);
end
