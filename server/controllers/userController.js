export const getUserInfo = async (req, res) => {
  const { name } = req.params;
  console.log(name);
  return;
  let { token, uuid } = req.body;

  try {
    const { error, value } = signinValidator.validate({ username, password });
    if (error) {
      return res.status(statuscodeMessages.BadRequest.statusCode).json({
        success: false,
        statusCode: statuscodeMessages.BadRequest.statusCode,
        message: error.details[0].message,
      });
    }

    const existingUser = await UserModel.findOne({ username }).select(
      "+hashedPassword"
    );

    if (!existingUser) {
      return res.status(statuscodeMessages.Conflict.statusCode).json({
        success: false,
        statusCode: statuscodeMessages.Conflict.statusCode,
        message: "Incorrect username or password",
      });
    }

    const hashedServerNoise = doHash(process.env.SERVER_NOISE);
    const hashedPwd = doHash(password, hashedServerNoise);

    if (!(hashedPwd == existingUser["hashedPassword"])) {
      return res.status(statuscodeMessages.Unauthorized.statusCode).json({
        success: false,
        statusCode: statuscodeMessages.Unauthorized.statusCode,
        message: "Incorrect username or password",
      });
    }

    if (!existingUser.uuid.includes(uuid)) {
      existingUser.uuid.push(uuid);
      existingUser.uuid = [...existingUser.uuid, uuid].slice(-30);
    }

    existingUser.exp = generateExp();

    const token = createJwtToken(
      {
        alg: existingUser.alg,
        typ: existingUser.typ,
      },
      {
        username: username,
        userId: existingUser._id,

        //uuid: userUuid,

        role: existingUser.role,
        createdAt: existingUser.createdAt,
        exp: existingUser.exp,
      },
      {
        hashedPwd: hashedPwd,
      }
    );

    // update database
    existingUser.verified = true;
    existingUser.save();

    res
      // .cookie('Authorization', 'Bearer ' + token, {
      //   expires: new Date(Date.now() + 8 * 3600000),
      //   httpOnly: process.env.NODE_ENV === ' production',
      //   secure: process.env.NODE_ENV === 'production'
      // })
      .json({
        success: true,
        statusCode: statuscodeMessages.OK.statusCode,
        message: "Logged in successfully",
        data: {
          token: token,
          cl: existingUser.cl,
        },
      });
  } catch (err) {
    console.log(`login in error:  ${err}`);
    res.status(statuscodeMessages.ServerError.statusCode).json({
      success: false,
      statusCode: statuscodeMessages.ServerError.statusCode,
      message: statuscodeMessages.ServerError.message,
    });
  }
};

// export const userRetrieve = async (req, res) => {
//   try {
//     const users = await UserModel.find().select(
//       "username role createdAt updatedAt -_id"
//     );

//     res.status(statuscodeMessages.OK.statusCode).json({
//       success: true,
//       statusCode: statuscodeMessages.OK.statusCode,
//       message: "User retrieve done!",
//       data: {
//         users: users,
//       },
//     });
//   } catch (err) {
//     console.error(err);
//     return res.status(statuscodeMessages.ServerError.statusCode).json({
//       success: false,
//       statusCode: statuscodeMessages.ServerError.statusCode,
//       message: err.message,
//     });
//   }
// };
