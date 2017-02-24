% This is to test that one run of general_least_squares_error produces the
% correct outputs.

classdef GeneralLSETest < matlab.unittest.TestCase
    properties
        % [L, strain_data] = general_least_squares_error(theta)
        theta
        L
        strain_data
        
        % global variables in general_least_squares_error.m
        adjacency_mat 
        alpha 
        b 
        is_forced 
        counter 
        deletion 
        fix_b 
        fix_P 
        log2FC 
        lse_out 
        penalty_out 
        prorate 
        production_function 
        strain_length 
        expression_timepoints 
        wts
        
        % global variables in general_network_dynamics___
        degrate
        num_genes
    end
    
    methods (TestClassSetup)
        function addGRNmapPath (testCase)
            addpath([pwd '/../../../matlab'])
        end
        
        function setupConstantVariables (testCase)
            testCase.alpha = 0;
            testCase.counter = 0;
            testCase.fix_b = 0;
            testCase.fix_P = 0;
            testCase.production_function = 'Sigmoid';
            testCase.strain_length = 1;
        end
        
        function runGLSE (testCase)
            global  alpha counter fix_b fix_P production_function ...
                 strain_length
                
            % these are globals inside general_network_dynamics___
            % global degrate num_genes
            
            alpha                 = testCase.alpha;
            counter               = testCase.counter;
            fix_b                 = testCase.fix_b;
            fix_P                 = testCase.fix_P;
            production_function   = testCase.production_function;
            strain_length         = testCase.strain_length;
        end
    end
    
    methods (TestClassTeardown)
        function teardown (testCase)
            clearvars -global
        end
    end
    
    methods (Test)
        function testLIsCorrectFor3Gene3EdgesControlCase (testCase)
            global adjacency_mat b degrate deletion expression_timepoints ...
                num_genes is_forced log2FC 
            
            adjacency_mat = [ 1 0 0
                              0 1 0 
                              0 0 1 ];
            b = [0; 0; 0];
            degrate = [0.5; 0.8; 1];
            deletion = 0;
            expression_timepoints = [5 10 20];
            num_genes = 3;
            is_forced = [1; 2; 3];
            log2FC = struct (...
                'Strain', {{'wt'}},...
                'deletion', {0}, ...
                't', struct ('indx', {[1 2 3 4]; [5 6 7 8]; [9 10 11 12 13]}, 't', {5; 10; 20}), ...
                'data', {[5 5 5 5 10 10 10 10 20 20 20 20 20
                          0 0 0 0 0  0  0  0  0  0  0  0  0
                          0 0 0 0 0  0  0  0  0  0  0  0  0
                          0 0 0 0 0  0  0  0  0  0  0  0  0
                         ]});
            testCase.theta = [0; 0; 0; 0; 0; 0; 1; 1.6; 2];
            [testCase.L, testCase.strain_data] = general_least_squares_error(testCase.theta); 
            
            % we need to test for strain_data later
            testCase.verifyEqual(testCase.L, 0);
        end
        
        function testLIsCorrectFor4Gene6EdgesControlCase (testCase)
            global adjacency_mat b degrate deletion expression_timepoints ...
                num_genes is_forced log2FC 
            
            adjacency_mat = [ 1 0 0 0
                              0 1 0 0
                              0 0 1 1
                              0 0 1 1];
            b = [0; 0; 0; 0];
            degrate = [1; 1; 1; 1];
            deletion = 0;
            expression_timepoints = [0.4 0.8 1.2 1.6];
            num_genes = 4;
            is_forced = [1; 2; 3; 4];
            log2FC = struct (...
                 'Strain', {{'wt'}},...
                 'deletion', {0}, ...
                 't', struct ('indx', {[1 2 3]; [4 5 6]; [7 8 9]; [10 11 12]}, 't', {0.4; 0.8; 1.2; 1.6}), ...
                 'data', {[0.4	0.4	0.4	0.8	0.8	0.8	1.2	1.2	1.2	1.6	1.6	1.6;...
                          -0.376334306292052	-0.376334306292052	-0.376334306292052	-0.706666467343382	-0.706666467343382	-0.706666467343382	-0.987239299670092	-0.987239299670092	-0.987239299670092	-1.21744326547615	-1.21744326547615	-1.21744326547615;...
                          -0.227718654239836	-0.227718654239836	-0.227718654239836	-0.408017743026565	-0.408017743026565	-0.408017743026565	-0.546412653239117	-0.546412653239117	-0.546412653239117	-0.649843860182989	-0.649843860182989	-0.649843860182989;...
                           0.269293821322375	 0.269293821322375   0.269293821322375	 0.415935372482249	 0.415935372482249	 0.415935372482249	 0.497511633589691	 0.497511633589691	 0.497511633589691	 0.541599938412416	 0.541599938412416	 0.541599938412416;...
                          -0.290936155220703	-0.290936155220703	-0.290936155220703	-0.579771801563864	-0.579771801563864	-0.579771801563864	-0.85583465653557	-0.85583465653557	-0.85583465653557	-1.10972623205696	-1.10972623205696	-1.10972623205696...
                          ]});
            testCase.theta = [0.499997576516624; 0.250002033939491; 0.504495199268528; 1.00983349545389; -0.999999026850515; 0.999996661159572; % Network weights
                              0; 0; 0; 0;                                                                                                       % Threshold
                              0.500000238187728; 0.999999131878006; 1.99480014741847; 1.00000082896524];                                        % Production rates
            [testCase.L, testCase.strain_data] = general_least_squares_error(testCase.theta); 
            
            % we need to test for strain_data later
            testCase.verifyTrue(abs(testCase.L - 0) < 1E-08); % round because we keep getting L = 1E-12
        end
        
        
    end
end