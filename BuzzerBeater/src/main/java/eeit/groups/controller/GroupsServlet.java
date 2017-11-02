package eeit.groups.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import eeit.games.model.GamesService;
import eeit.groupreg.model.GroupRegService;
import eeit.groupreg.model.GroupRegVO;
import eeit.groups.model.GroupsService;
import eeit.groups.model.GroupsVO;
import eeit.season.model.SeasonService;

@WebServlet("/Groups.do")
public class GroupsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GroupsServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		if ("GET_ONE_TO_SIGNUP".equals(action)) {
			Integer teamID = new Integer(request.getParameter("teamID"));
			Integer groupID = new Integer(request.getParameter("groupID"));

			GroupRegService grSvc = new GroupRegService();
			grSvc.insert(groupID, teamID);

			request.getRequestDispatcher("/groups/signupGroup.jsp").forward(request, response);
		}

		if ("GET_GROUP_SIGNUP".equals(action)) {
			Integer teamID = new Integer(request.getParameter("teamID"));

			GroupsService gSvc = new GroupsService();
			Set<GroupsVO> groupsSet = gSvc.getAll();

			List<Map<String, Object>> newList = new LinkedList<Map<String, Object>>();
			Map<String, Object> newMap = null;

			for (GroupsVO groupsVO : groupsSet) {

				if (groupsVO.getSeasonVO().getSignUpEnd().after(Calendar.getInstance().getTime())
						&& groupsVO.getSeasonVO().getSignUpBegin().before(Calendar.getInstance().getTime())) {
					newMap = new HashMap<String, Object>();
					newMap.put("seasonName", groupsVO.getSeasonVO().getSeasonName());
					newMap.put("groupID", groupsVO.getGroupID());
					newMap.put("groupName", groupsVO.getGroupName());
					newMap.put("signUpBegin", groupsVO.getSeasonVO().getSignUpBegin());
					newMap.put("signUpEnd", groupsVO.getSeasonVO().getSignUpEnd());
					newMap.put("currentTeams", groupsVO.getCurrentTeams());
					newMap.put("maxTeams", groupsVO.getMaxTeams());
					newMap.put("minTeams", groupsVO.getMinTeams());
					newMap.put("maxPlayer", groupsVO.getMaxPlayers());
					newMap.put("minPlayer", groupsVO.getMinPlayers());

					for (GroupRegVO grVO : groupsVO.getGroupRegSet()) {
						if (grVO.getTeamsVO().getTeamID().equals(teamID)) {
							newMap.put("teamStat", grVO.getTeamStat());
						}
					}

					newList.add(newMap);
				}
			}

			request.setAttribute("signUpList", newList);
			request.getRequestDispatcher("/groups/signupGroup.jsp").forward(request, response);
		}

		if ("REMOVE_GROUP_TEMP".equals(action)) {
			// 取得groupsSet Session
			HttpSession session = request.getSession();
			Set<GroupsVO> groupsSet = (Set<GroupsVO>) session.getAttribute("groupsSet");

			// 取得Set的Index值，該值由前端JSP網頁取值時順便計算並回傳
			Integer setIndex = new Integer(request.getParameter("setIndex"));

			// 計算Set的Index值，當該值與回傳值相同時將其刪除
			GroupsVO gVO = null;
			int i = 0;
			for (GroupsVO vo : groupsSet) {
				if (i++ == setIndex) {
					gVO = vo;
				}
			}
			groupsSet.remove(gVO);

			// 設置刪除完成後的groupsSet
			session.setAttribute("groupsSet", groupsSet);

			// 返回原網頁
			RequestDispatcher successView = request.getRequestDispatcher("/groups/addGroups.jsp");
			successView.forward(request, response);
		}

		if ("CHECK_GROUP".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			GroupsVO groupsVO = null;

			try {
				String groupName = request.getParameter("groupName");
				if (groupName == null || groupName.trim().length() == 0) {
					errorMsgs.add("請輸入分組名稱");
				} else if (!groupName.trim().matches("^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$")) {
					errorMsgs.add("分組名稱只能是中、英文字母、數字和 _ , 且長度必需在2到10之間");
				}

				Integer maxTeams = null;
				try {
					maxTeams = new Integer(request.getParameter("maxTeams"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("球隊數量上限:請輸入數字");
				}

				Integer minTeams = null;
				try {
					minTeams = new Integer(request.getParameter("minTeams"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("球隊數量下限:請輸入數字");
				}

				if (maxTeams != null && minTeams != null & maxTeams < minTeams) {
					errorMsgs.add("球隊數量上限必須大於或等於球隊數量下限");
				}

				Integer maxPlayers = null;
				try {
					maxPlayers = new Integer(request.getParameter("maxPlayers"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("球隊成員上限:請輸入數字");
				}

				Integer minPlayers = null;
				try {
					minPlayers = new Integer(request.getParameter("minPlayers"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("球隊成員下限:請輸入數字");
				}

				if (maxPlayers != null && minPlayers != null & maxPlayers < minPlayers) {
					errorMsgs.add("球隊成員上限必須大於或等於球隊成員下限");
				}

				groupsVO = new GroupsVO();
				groupsVO.setGroupName(groupName);
				groupsVO.setMaxTeams(maxTeams);
				groupsVO.setMinTeams(minTeams);
				groupsVO.setMaxPlayers(maxPlayers);
				groupsVO.setMinPlayers(minPlayers);
				groupsVO.setGroupID((int) (Math.random() * 1000000) + 1);

				// 錯誤處理
				if (!errorMsgs.isEmpty()) {
					request.setAttribute("groupsVO", groupsVO);
					RequestDispatcher failVeiw = request.getRequestDispatcher("/groups/addGroups.jsp");
					failVeiw.forward(request, response);
					return;
				}

				HttpSession session = request.getSession();
				Set<GroupsVO> groupsSet = null;

				// 成功後放入groupsSet中等待下一筆
				if ((groupsSet = (Set<GroupsVO>) session.getAttribute("groupsSet")) == null) {
					groupsSet = new LinkedHashSet<GroupsVO>();
				}

				groupsSet.add(groupsVO);

				session.setAttribute("groupsSet", groupsSet);
				RequestDispatcher successView = request.getRequestDispatcher("/groups/addGroups.jsp");
				successView.forward(request, response);

			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				request.setAttribute("groupsVO", groupsVO);
				RequestDispatcher failView = request.getRequestDispatcher("/groups/addGroups.jsp");
				failView.forward(request, response);
			}

		}

		if ("GET_ONE_TO_UPDATE".equals(action)) {
			Integer groupID = Integer.parseInt(request.getParameter("groupID"));

			GroupsService svc = new GroupsService();
			request.setAttribute("groupsVO", svc.findByGroupID(groupID));
			request.getRequestDispatcher("/groups/updateGroup.jsp").forward(request, response);
		}

		if ("ADD_GROUP".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			GroupsVO groupsVO = null;
			try {

				String groupName = request.getParameter("groupName");
				if (groupName == null || groupName.trim().length() == 0) {
					errorMsgs.add("請輸入分組名稱");
				} else if (!groupName.trim().matches("^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$")) {
					errorMsgs.add("分組名稱只能是中、英文字母、數字和 _ , 且長度必需在2到10之間");
				}

				Integer maxTeams = null;
				try {
					maxTeams = new Integer(request.getParameter("maxTeams"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("球隊數量上限:請輸入數字");
				}

				Integer minTeams = null;
				try {
					minTeams = new Integer(request.getParameter("minTeams"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("球隊數量下限:請輸入數字");
				}

				if (maxTeams != null && minTeams != null & maxTeams < minTeams) {
					errorMsgs.add("球隊數量上限必須大於或等於球隊數量下限");
				}

				Integer maxPlayers = null;
				try {
					maxPlayers = new Integer(request.getParameter("maxPlayers"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("球隊成員上限:請輸入數字");
				}

				Integer minPlayers = null;
				try {
					minPlayers = new Integer(request.getParameter("minPlayers"));
				} catch (IllegalArgumentException e) {
					errorMsgs.add("球隊成員下限:請輸入數字");
				}

				if (maxPlayers != null && minPlayers != null & maxPlayers < minPlayers) {
					errorMsgs.add("球隊成員上限必須大於或等於球隊成員下限");
				}

				Integer seasonID = new Integer(request.getParameter("seasonID"));

				groupsVO = new GroupsVO();
				groupsVO.setGroupName(groupName);
				groupsVO.setMaxPlayers(maxPlayers);
				groupsVO.setMinPlayers(minPlayers);
				groupsVO.setMaxTeams(maxTeams);
				groupsVO.setMinTeams(minTeams);

				if (!errorMsgs.isEmpty()) {
					request.setAttribute("groupsVO", groupsVO);
					RequestDispatcher failView = request.getRequestDispatcher("/groups/addGroups.jsp");
					failView.forward(request, response);
					return;
				}

				GroupsService gSvc = new GroupsService();
				gSvc.addGroups(seasonID, groupName, maxTeams, minTeams, maxPlayers, minPlayers);

				SeasonService sSvc = new SeasonService();
				request.setAttribute("seasonVO", sSvc.findBySeasonID(seasonID));
				RequestDispatcher successView = request.getRequestDispatcher("/groups/addGroups.jsp");
				successView.forward(request, response);

			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				request.setAttribute("groupsVO", groupsVO);
				RequestDispatcher failView = request.getRequestDispatcher("/groups/addGroups.jsp");
				failView.forward(request, response);
			}
		}

		if ("GET_GAMES".equals(action)) {
			Integer groupID = Integer.parseInt(request.getParameter("groupID"));
			GroupsService gSvc = new GroupsService();

			request.setAttribute("groupsVO", gSvc.findByGroupID(groupID));
			RequestDispatcher successView = request.getRequestDispatcher("/games/gameList.jsp");
			successView.forward(request, response);

		}

		if ("DELETE_GROUP".equals(action)) {
			GroupsService svc = new GroupsService();
			Integer groupID = Integer.parseInt(request.getParameter("groupID"));
			GroupsVO groupsVO = svc.findByGroupID(groupID);
			Integer seasonID = groupsVO.getSeasonVO().getSeasonID();
			svc.delete(groupID);

			request.getRequestDispatcher("/Season.do?action=TO_GROUPS_BACK&seasonID=" + seasonID).forward(request,
					response);
		}

		if ("ADD_SCHEDULE".equals(action)) {
			Integer groupID = Integer.parseInt(request.getParameter("groupID"));
			GroupsService gsvc = new GroupsService();
			GroupsVO groupsVO = gsvc.findByGroupID(groupID);
			Integer currentTeams = groupsVO.getCurrentTeams();
			Integer gamesNeeded = (currentTeams * (currentTeams - 1)) / 2;

			request.getSession().setAttribute("groupsVO", groupsVO);
			request.getSession().setAttribute("gamesNeeded", gamesNeeded);
			request.getRequestDispatcher("/groups/addSchedule.jsp").forward(request, response);
		}

		if ("SPLIT_LOCATION".equals(action)) {
			HttpSession session = request.getSession();
			Integer locationID = new Integer(request.getParameter("locationID").split(",")[0]);
			String locationName = request.getParameter("locationID").split(",")[1];
			Timestamp beginDate = Timestamp.valueOf(request.getParameter("beginDate"));
			Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate"));

			Integer timeunit = Integer.parseInt(request.getParameter("timeUnit"));
			long timeUnit = TimeUnit.MINUTES.convert(timeunit, TimeUnit.MINUTES);

			// 如果session裡面原本沒有此list則創建一個
			List<Map<String, Object>> list = null;
			if ((list = (List<Map<String, Object>>) session.getAttribute("timeList")) == null) {
				list = new ArrayList<Map<String, Object>>();
			}

			// 拆解時間並加入
			Map<String, Object> map = null;
			Timestamp beginTime = beginDate;
			Timestamp endTime = null;
			while (true) {
				endTime = new Timestamp(beginTime.getTime() + timeUnit * 60 * 1000);
				if (endTime.after(endDate)) {
					break;
				}

				map = new HashMap<String, Object>();
				map.put("beginTime", beginTime);
				map.put("endTime", endTime);
				map.put("locationID", locationID);
				map.put("locationName", locationName);
				map.put("timeUnit", timeunit);
				list.add(map);
				beginTime = endTime;
			}

			// 放入session並轉交
			session.setAttribute("timeList", list);
			request.getRequestDispatcher("/groups/addSchedule.jsp").forward(request, response);
		}

		if ("REMOVE_TIMELIST".equals(action)) {
			HttpSession session = request.getSession();
			int index = Integer.valueOf(request.getParameter("index"));

			List<Map<String, Object>> timeList = (List<Map<String, Object>>) session.getAttribute("timeList");

			timeList.remove(index);

			session.removeAttribute("timeList");
			session.setAttribute("timeList", timeList);
			request.getRequestDispatcher("/groups/addSchedule.jsp").forward(request, response);
		}

		if ("MAKE_SCHEDULE".equals(action)) {
			Integer groupID = Integer.valueOf(request.getParameter("groupID"));
			HttpSession session = request.getSession();
			List<Map<String, Object>> timeList = (List<Map<String, Object>>) session.getAttribute("timeList");
			Integer gamesNeeded = (Integer) session.getAttribute("gamesNeeded");

			// 場數不足回傳錯誤
			if (timeList.size() < gamesNeeded) {
				List<String> errorMsgs = new LinkedList<String>();
				errorMsgs.add("場數不足");
				request.setAttribute("errorMsgs", errorMsgs);
				request.getRequestDispatcher("/groups/addSchedule.jsp").forward(request, response);
				return;
			}

			// 取得所有球隊
			GroupRegService grSvc = new GroupRegService();
			List<GroupRegVO> groupRegList = grSvc.findByGroupID(groupID);

			// 若球隊數量為奇數加入一隊空隊伍
			if (groupRegList.size() / 2 == 0) {
				groupRegList.add(new GroupRegVO());
			}

			List<Integer[]> schedule = new ArrayList<Integer[]>();
			int total = 0;
			int count = groupRegList.size();
			GroupRegVO gVO = new GroupRegVO();
			for (int j = 1; j < count; j++) {
				for (int i = 0; i <= (count / 2) - 1; i++) {
					if (groupRegList.get(i) != gVO && groupRegList.get(count - 1 - i) != gVO) {
						Integer[] teamvs = { groupRegList.get(i).getTeamsVO().getTeamID(),
								groupRegList.get(count - 1 - i).getTeamsVO().getTeamID() };
						schedule.add(teamvs);
						total += 1;
					}
				}
				groupRegList.add(groupRegList.get(1));
				groupRegList.remove(1);
			}

			for (int i = 0; i < 100; i++) {
				int rd = (int) (Math.random() * total - 1);
				schedule.add(schedule.get(rd));
				schedule.remove(rd);
			}

			GamesService gSvc = new GamesService();
			for (int i = 0; i < gamesNeeded; i++) {
				Integer locationID = (Integer) timeList.get(i).get("locationID");
				Timestamp gameBeginDate = (Timestamp) timeList.get(i).get("beginTime");
				Timestamp gameEndDate = (Timestamp) timeList.get(i).get("endTime");
				Integer teamAID = schedule.get(i)[0];
				Integer teamBID = schedule.get(i)[1];

				gSvc.addGames(groupID, locationID, teamAID, 0, teamBID, 0, gameBeginDate, gameEndDate);
			}

			session.removeAttribute("timeList");
			session.removeAttribute("gamesNeeded");
			session.removeAttribute("groupsVO");

			request.getRequestDispatcher("/Games.do?action=GET_GAMES&groupID=" + groupID).forward(request, response);
		}

	}

}
