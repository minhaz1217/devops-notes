const sutName = "CaseService";
const lines = `

        private readonly ILogger<CaseService> _logger;
        private readonly IReadDataService _readDataService;
        private readonly IRepository _repository;
        private readonly IMongoSecurityService _ecapSecurityService;
        private readonly INotificationService _notificationProviderService;
        private readonly IServiceClient _serviceClient;
        private readonly ICreateDocumentToParashiftService _createDocumentToParashift;
        private readonly ISecurityContextProvider _securityContextProvider;
        private readonly IEmailNotifierService _emailNotifierService;
        private readonly ISLAService _slaService;
        private readonly IIpexService _ipexService;
        private readonly ICommonUtilService _commonUtilService;
        private readonly IRetryableUntilExtracted _retryableUntilExtracted;
        private readonly IProcessServiceProvider _serviceProvider;
        private readonly ICaseDocumentDataMapper _caseDocumentDataMapper;
        private readonly IFileService _fileService;
        private readonly BexioEnvironmentConfig _bexioEnvironmentConfig;
`;

let output = "\n\n";
let privateObjects = [];
for (let line of lines.split("\n")) {
  if (line.trim() !== "") {
    const splitted = line.split(" ");
    privateObjects.push(splitted[splitted.length - 1].replace(";", ""));
    /* console.log(splitted[splitted.length -2]); */
    splitted[splitted.length - 2] = `Mock<${splitted[splitted.length -2]}>`;
    output += (decodeURI(splitted.join(" "))) + "\n";
  }
}

output += `\t\t\t\tpublic ${sutName}Test(){\n`;

for (let line of lines.split("\n")) {
  if (line.trim() !== "") {
    const splitted = line.split(" ");
    /* console.log(splitted[splitted.length -2]); */
    splitted[splitted.length - 2] = `Mock<${splitted[splitted.length -2]}>`;
    splitted[splitted.length - 1] = splitted[splitted.length - 1].replace(";", "")
    output += `\t\t\t\t\t\t\t\t${splitted[splitted.length-1]} = new ${splitted[splitted.length -2]}();\n`;
  }
}

output += "\t\t\t\t}\n\n";

let constructorObjects = [];
for (let line of lines.split("\n")) {
  if (line.trim() !== "") {
    const splitted = line.split(" ");
    splitted[splitted.length - 1] = splitted[splitted.length - 1].replace(";", "")
    constructorObjects.push(`${splitted[splitted.length-1]}.Object`);
  }
}
output += `
    #region basics
    private ${sutName} CreateSut()
    {
        return new ${sutName}(${constructorObjects.join(",")});
    }

    private ${sutName} CreateSutForPrivateTesting()
    {
        var type = typeof(${sutName});
        var sut = (${sutName})Activator.CreateInstance(type, 
          ${constructorObjects.join(",")}
        );
        return sut;
    }

    [Fact]
    public void Sut_For_Public_Testing_Should_Init_Properly()
    {
        // assign
        var sut = CreateSut();

        // assert
        Assert.True(sut is not null);
        Assert.IsType<${sutName}>(sut);
        Assert.Equal(typeof(${sutName}), sut.GetType());
    }

    [Fact]
    public void Sut_For_Private_Testing_Should_Init_Properly()
    {
        // assign
        var sut = CreateSutForPrivateTesting();

        // assert
        Assert.True(sut is not null);
        Assert.IsType<${sutName}>(sut);
        Assert.Equal(typeof(${sutName}), sut.GetType());
    }

    [Fact]
    public void Handle_Should_Throw_Exception()
    {
        var exceptionType = typeof(NotImplementedException);

        // Act and Assert
        var sut = CreateSut();
        Assert.Throws(exceptionType, () =>
        {
            ${sutName.replace("Handler","")} payload = null;
            sut.Handle(payload);
        });
    }

    [Fact]
    public void Handle_Should_Return_Properly()
    {
        // arrange

        // assign
        var sut = CreateSut();

        ${sutName.replace("Handler","")} payload = null;
        var result = sut.Handle(payload);

        // assert
        Assert.IsType<CommandResponse>(result);
    }
    private void VerifyAll()
    {
        ${[...privateObjects, ""].join(".Verify();\n\t\t\t\t")}
    }
    #endregion basics
\n\n`;

console.log(output);

// navigator.clipboard.writeText(output).then(function() {
//   console.log('Async: Copying to clipboard was successful!');
// }, function(err) {
//   console.error('Async: Could not copy text: ', err);
// });
