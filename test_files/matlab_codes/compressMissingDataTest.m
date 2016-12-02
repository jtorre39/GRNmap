classdef compressMissingDataTest < matlab.unittest.TestCase
    
    properties(ClassSetupParameter)
       test_data = { struct('input_GRNstruct', 'GRNstruct_with_one_NaN', 'expected_GRNstruct', 'expected_output_for_GRNstruct_with_one_NaN') };
    end

    properties
        test_dir = '..\compress_missing_data_tests\'
        GRNstruct
        expected_GRNstruct
    end

    methods(TestClassSetup)
        function addPath(testCase) %#ok<MANU>
            addpath([pwd '/../../matlab']);
            addpath([pwd 'tests']);
        end
        
        function setupGRNstruct(testCase, test_data)
            testCase.GRNstruct = getfield(CompressMissingDataStruct, test_data.input_GRNstruct);
            testCase.expected_GRNstruct = getfield(CompressMissingDataStruct, test_data.expected_GRNstruct);
        end
    end

    methods (Test)
        function testOne(testCase)
            disp(testCase.GRNstruct.expressionData(1).data);
            disp(testCase.expected_GRNstruct.expressionData(1).data);
            actual = compressMissingData(testCase.GRNstruct);
            expected = testCase.expected_GRNstruct;
            testCase.verifyEqual(actual, expected);
        end
        
        function testExpressionDataStructureWithoutMissingData(testCase)
            testCase.GRNstruct.inputFile = [testCase.test_dir 'Control_4-genes_6-edges_artificial-data_MM_estimation_fixP-0_graph.xlsx'];
            testCase.GRNstruct = readInputSheet(testCase.GRNstruct);
            testCase.GRNstruct = compressMissingData(testCase.GRNstruct);
            testCase.verifyTrue(isequal(testCase.GRNstruct.expressionData(1).data, {
                0.4, 0.8, 1.2, 1.6;...
                % ACE2
                [-0.376334306292052	-0.376334306292052 -0.376334306292052; 1 2 3],...
                [-0.706666467343382	-0.706666467343382 -0.706666467343382; 1 2 3],...
                [-0.987239299670092	-0.987239299670092 -0.987239299670092; 1 2 3],...
                [-1.21744326547615 -1.21744326547615 -1.21744326547615; 1 2 3];...
                % AFT2
                [-0.227718654239836	-0.227718654239836 -0.227718654239836; 1 2 3],...
                [-0.408017743026565	-0.408017743026565 -0.408017743026565; 1 2 3],...
                [-0.546412653239117	-0.546412653239117 -0.546412653239117; 1 2 3],...
                [-0.649843860182989	-0.649843860182989 -0.649843860182989; 1 2 3];...
                % CIN5
                [0.269293821322375 0.269293821322375 0.269293821322375; 1 2 3],...
                [0.415935372482249 0.415935372482249 0.415935372482249; 1 2 3],...
                [0.497511633589691 0.497511633589691 0.497511633589691; 1 2 3],...
                [0.541599938412416 0.541599938412416 0.541599938412416; 1 2 3];...
                % FHL1
                [-0.290936155220703	-0.290936155220703 -0.290936155220703; 1 2 3],...
                [-0.579771801563864	-0.579771801563864 -0.579771801563864; 1 2 3],...
                [-0.85583465653557 -0.85583465653557 -0.85583465653557; 1 2 3],...
                [-1.10972623205696 -1.10972623205696 -1.10972623205696; 1 2 3]
            }));
            testCase.verifyTrue(isequal(testCase.GRNstruct.expressionData(2).data, {
                0.4, 0.8, 1.2, 1.6;...
                % ACE2
                [-0.376334306292052	-0.376334306292052 -0.376334306292052; 1 2 3],...
                [-0.706666467343382	-0.706666467343382 -0.706666467343382; 1 2 3],...
                [-0.987239299670092	-0.987239299670092 -0.987239299670092; 1 2 3],...
                [-1.21744326547615 -1.21744326547615 -1.21744326547615; 1 2 3];...
                % AFT2
                [-0.227718654239836	-0.227718654239836 -0.227718654239836; 1 2 3],...
                [-0.408017743026565	-0.408017743026565 -0.408017743026565; 1 2 3],...
                [-0.546412653239117	-0.546412653239117 -0.546412653239117; 1 2 3],...
                [-0.649843860182989	-0.649843860182989 -0.649843860182989; 1 2 3];...
                % CIN5
                [0 0 0; 1, 2, 3],...
                [0 0 0; 1, 2, 3],...
                [0 0 0; 1, 2, 3],...
                [0 0 0; 1, 2, 3];...
                % FHL1
                [-0.13932150464649 -0.13932150464649 -0.13932150464649; 1 2 3],...
                [-0.249851730445413	-0.249851730445413 -0.249851730445413; 1 2 3],...
                [-0.336140688374095	-0.336140688374095 -0.336140688374095; 1 2 3],...
                [-0.402590113617106	-0.402590113617106 -0.402590113617106; 1 2 3]
            }));
        end
        
        function testExpressionDataStructureWithMissingData(testCase)
            testCase.GRNstruct.inputFile = [testCase.test_dir 'MissingData_4-genes_6-edges_artificial-data_MM_estimation_fixP-0_graph.xlsx'];
            testCase.GRNstruct = readInputSheet(testCase.GRNstruct);
            testCase.GRNstruct = compressMissingData(testCase.GRNstruct);
            testCase.verifyTrue(isequal(testCase.GRNstruct.expressionData(1).data, {
                0.4, 0.8, 1.2, 1.6;...
                % ACE2
                [-0.376334306292052	-0.376334306292052; 1 2],...
                [-0.706666467343382	-0.706666467343382; 1 2],...
                [-0.987239299670092	-0.987239299670092 -0.987239299670092; 1 2 3],...
                [-1.21744326547615 -1.21744326547615 -1.21744326547615; 1 2 3];...
                % AFT2
                [-0.227718654239836	-0.227718654239836 -0.227718654239836; 1 2 3],...
                [-0.408017743026565 -0.408017743026565; 2 3],...
                [-0.546412653239117	-0.546412653239117 -0.546412653239117; 1 2 3],...
                [-0.649843860182989 -0.649843860182989; 2 3];...
                % CIN5
                [0.269293821322375 0.269293821322375; 1 3],...
                [0.415935372482249 0.415935372482249; 1 3],...
                [0.497511633589691 0.497511633589691; 1 2],...
                [0.541599938412416 0.541599938412416 0.541599938412416; 1 2 3];...
                % FHL1
                [-0.290936155220703	-0.290936155220703 -0.290936155220703; 1 2 3],...
                [-0.579771801563864	-0.579771801563864 -0.579771801563864; 1 2 3],...
                [-0.85583465653557 -0.85583465653557 -0.85583465653557; 1 2 3],...
                [-1.10972623205696 -1.10972623205696; 1 2]
            }));
        end
        
        function testExpressionDataStructureWithInconsistentTimepointData(testCase)
            testCase.GRNstruct.inputFile = [testCase.test_dir 'InconsistentTimepoints_4-genes_6-edges_artificial-data_MM_estimation_fixP-0_graph.xlsx'];
            testCase.GRNstruct = readInputSheet(testCase.GRNstruct);
            testCase.GRNstruct = compressMissingData(testCase.GRNstruct);
            testCase.verifyTrue(isequal(testCase.GRNstruct.expressionData(1).data, {
                0.4, 0.8, 1.2, 1.6;...
                % ACE2
                [-0.376334306292052	-0.376334306292052 -0.376334306292052 -0.706666467343382; 1 2 3 4],...
                [-0.706666467343382 -0.706666467343382; 1 2],...
                [-0.987239299670092	-0.987239299670092 -0.987239299670092; 1 2 3],...
                [-1.21744326547615 -1.21744326547615; 1 2];...
                % AFT2
                [-0.227718654239836	-0.227718654239836 -0.227718654239836 -0.408017743026565; 1 2 3 4],...
                [-0.408017743026565 -0.408017743026565; 1 2],...
                [-0.546412653239117	-0.546412653239117 -0.546412653239117; 1 2 3],...
                [-0.649843860182989	-0.649843860182989; 1 2];...
                % CIN5
                [0.269293821322375 0.269293821322375 0.269293821322375 0.415935372482249; 1 2 3 4],...
                [0.415935372482249 0.415935372482249; 1 2],...
                [0.497511633589691 0.497511633589691 0.497511633589691; 1 2 3],...
                [0.541599938412416 0.541599938412416; 1 2];...
                % FHL1
                [-0.290936155220703	-0.290936155220703 -0.290936155220703 -0.579771801563864; 1 2 3 4],...
                [-0.579771801563864 -0.579771801563864; 1 2],...
                [-0.85583465653557 -0.85583465653557 -0.85583465653557; 1 2 3],...
                [-1.10972623205696 -1.10972623205696; 1 2]
            }));
        end
        
        function testExpressionDataStructureWithTooMuchMissingData(testCase)
            testCase.GRNstruct.inputFile = [testCase.test_dir 'MissingTooMuchData_4-genes_6-edges_artificial-data_MM_estimation_fixP-0_graph.xlsx'];
            testCase.GRNstruct = readInputSheet(testCase.GRNstruct);
            testCase.GRNstruct = compressMissingData(testCase.GRNstruct);
            testCase.verifyTrue(isequal(testCase.GRNstruct.expressionData(1).data, {
                0.4, 0.8, 1.2, 1.6;...
                % ACE2
                [],...
                [-0.706666467343382	-0.706666467343382 -0.706666467343382; 1 2 3],...
                [-0.987239299670092	-0.987239299670092 -0.987239299670092; 1 2 3],...
                [-1.21744326547615 -1.21744326547615 -1.21744326547615; 1 2 3];...
                % AFT2
                [-0.227718654239836	-0.227718654239836 -0.227718654239836; 1 2 3],...
                [],...
                [-0.546412653239117	-0.546412653239117 -0.546412653239117; 1 2 3],...
                [-0.649843860182989	-0.649843860182989 -0.649843860182989; 1 2 3];...
                % CIN5
                [0.269293821322375 0.269293821322375 0.269293821322375; 1 2 3],...
                [0.415935372482249 0.415935372482249 0.415935372482249; 1 2 3],...
                [0.497511633589691 0.497511633589691 0.497511633589691; 1 2 3],...
                [];...
                % FHL1
                [-0.290936155220703	-0.290936155220703 -0.290936155220703; 1 2 3],...
                [-0.579771801563864	-0.579771801563864 -0.579771801563864; 1 2 3],...
                [],...
                [-1.10972623205696 -1.10972623205696 -1.10972623205696; 1 2 3]
            }));
        end
    end
end
